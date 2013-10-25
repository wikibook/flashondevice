/**
 * Use it when you want to implement AbstractView in your class.
 * 
 * @see AbstractView
 */
interface com.blocketpc.view.IView
{
	public function initialize():Void;
	public function onResize():Void;
	public function open():Void;
	public function onOpen():Void;
	public function close():Void;
	public function onClose():Void;
}