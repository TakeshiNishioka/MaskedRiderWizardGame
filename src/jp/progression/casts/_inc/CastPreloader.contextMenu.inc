import flash.ui.ContextMenu;

public override function get contextMenu():ContextMenu { return _contextMenu; }
public override function set contextMenu( value:ContextMenu ):void {
	if ( _allowBuildContextMenu ) {
		super.contextMenu = value;
	}
	else {
		_contextMenu = value;
		
		// すでに存在していれば
		if ( super.contextMenu && _managerClass ) {
			// コンテクストメニューを再構築する
			var cls:Class = _managerClass.config.contextMenuBuilder;
			if ( cls ) {
				_allowBuildContextMenu = true;
				_contextMenuBuilder = new cls( this );
				_allowBuildContextMenu = false;
			}
		}
	}
}
private var _contextMenu:ContextMenu;
