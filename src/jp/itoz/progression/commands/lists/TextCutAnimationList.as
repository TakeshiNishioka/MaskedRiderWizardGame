/**
 *============================================================
 * copyright(c). www.itoz.jp
 * @author  itoz
 *============================================================
 * -2011.4.18 パッケージ変更
 */
package jp.itoz.progression.commands.lists
{
    import jp.progression.commands.Func;
    import jp.progression.commands.Wait;
    import jp.progression.commands.lists.SerialList;

    import flash.text.TextField;
	
	/**
	 * TextFieldの文字を1文字づつ、消去していくアニメーションコマンドリスト
	 */
	public class TextCutAnimationList extends SerialList
	{
		private var _initObj 	: Object;
		private var _textField 	: TextField;
		private var _speed 		: Number;
		private var _addCount : int;
		
		/**
		 * コンストラクタ
		 * @param initObj
		 * @param textField
		 * @param speed
		 */
		function TextCutAnimationList ( initObj : Object ,
	 								textField:TextField,
	 								speed:Number =0.03
	 								)
		{
			super( initObj);
			
			_initObj	= initObj;
			_textField	= textField;
			_speed		= speed;
			_addCount	= 0;
			addCommand( 
				function () : void {
					var max : int = _textField.text.length;
					if( max >_addCount){
						while (max >= 0) {
							_addCount++;
							addCommand( new Wait( _speed ) );
							addCommand( 
								new Func( 
									function (num : int) : void {
										_textField.text = _textField.text.slice( 0 , num );
									} , [max] ) 
							);
							max -= 1;
						}
					}
				}
			);
		}
		
		/**
		 * インスタンスのコピー
		 */
//		override public function clone():Command {
//			return new TextCutAnimation( _initObj,_textField,_speed);
//		}
	}
}
