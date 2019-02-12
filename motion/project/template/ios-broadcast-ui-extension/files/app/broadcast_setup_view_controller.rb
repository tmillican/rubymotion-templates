class BroadcastSetupViewController < UIViewController
  # Enable 'IB' if you want to use storyboard.
  # extend IB

  def viewDidLoad
    super

    alert_controller = UIAlertController.alertControllerWithTitle(
      'Dummy Broadcast Service',
      message: 'This service does nothing.',
      preferredStyle: UIAlertControllerStyleAlert)
    cancel_action = UIAlertAction.actionWithTitle(
      'Cancel',
      style: UIAlertActionStyleDefault,
      handler: Proc.new { |action| userDidCancelSetup })
    broadcast_action = UIAlertAction.actionWithTitle(
      'Broadcast',
      style: UIAlertActionStyleDefault,
      handler: Proc.new { |action| userDidFinishSetup })
    alert_controller.addAction(cancel_action)
    alert_controller.addAction(broadcast_action)
    self.presentViewController(alert_controller, animated: true, completion: nil)
  end

  # Called when the user has finished interacting with the view controller and a broadcast stream can start
  def userDidFinishSetup
    NSLog('userDidFinishSetup called.')

    # URL of the resource where broadcast can be viewed that will be returned to
    # the application
    broadcast_url = NSURL.URLWithString('http://apple.com/broadcast/streamID')

    # Dictionary with setup information that will be provided to broadcast
    # extension when broadcast is started
    setup_info = { 'broadcastName' => 'example' }

    # Tell ReplayKit that the extension is finished setting up and can begin
    # broadcasting
    self.extensionContext.completeRequestWithBroadcastURL(
      broadcast_url, setupInfo: setup_info)
  end

  def userDidCancelSetup
    NSLog('userDidCancelSetup called.')
    # Tell ReplayKit that the extension was cancelled by the user
    self.extensionContext.cancelRequestWithError(
      NSError.errorWithDomain("YourAppDomain", code: -1, userInfo: nil))
  end

end
