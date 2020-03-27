/**
 * Progression 4
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://progression.jp/
 * 
 * Progression Software is released under the Progression Software License:
 * http://progression.jp/ja/overview/license
 * 
 * Progression Libraries is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.progression.core.utils {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ClassUtil;
	import jp.progression.commands.Command;
	import jp.progression.commands.CommandList;
	import jp.progression.commands.Func;
	import jp.progression.commands.lists.ParallelList;
	import jp.progression.commands.lists.SerialList;
	import jp.progression.commands.Trace;
	import jp.progression.commands.Wait;
	
	/**
	 * @private
	 */
	public class CommandUtil {
		
		/**
		 * @private
		 */
		public function CommandUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>指定された配列に含まれるデータ型に応じて、最適なコマンドに変換して返します。</p>
		 * <p></p>
		 * 
		 * @param target
		 * <p>変換の起点となるコマンドです。</p>
		 * <p></p>
		 * @param commands
		 * <p>変換したいオブジェクトを含む配列です。</p>
		 * <p></p>
		 * @return
		 * <p>返還後のコマンドを含む配列です。</p>
		 * <p></p>
		 */
		public static function convert( target:Command, commands:Array ):Array {
			for ( var i:int = 0, l:int = commands.length; i < l; i++ ) {
				var value:* = commands[i];
				
				// 型に応じて変換する
				switch ( true ) {
					// Command インスタンス、または null であれば次へ
					case value == undefined	:
					case value == null		:
					case value is Command	: { break; }
					
					// 関数であれば Func コマンドに変換する
					case value is Function	: { commands[i] = new Func( value as Function ); break; }
					
					// 数値であればディレイ付き Command コマンドに変換する
					case value is Number	: { commands[i] = new Wait( value ); break; }
					
					// 配列であればシンタックスシュガーとして処理する
					case value is Array		: {
						var list:CommandList;
						
						switch ( true ) {
							case target is SerialList		: { list = new ParallelList(); break; }
							case target is ParallelList		:
							default							: { list = new SerialList(); }
						}
						
						list.addCommand.apply( null, value as Array );
						commands[i] = list;
						break;
					}
					
					// それ以外は全て Trace コマンドに変換する
					default					: { commands[i] = new Trace( "trace: " + value ); }
				}
			}
			
			return commands;
		}
	}
}
