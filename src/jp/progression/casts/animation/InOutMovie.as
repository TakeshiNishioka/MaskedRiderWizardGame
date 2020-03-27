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
package jp.progression.casts.animation {
	import flash.display.MovieClip;
	import jp.progression.commands.tweens.DoTweenFrame;
	import jp.progression.core.casts.AnimationBase;
	import jp.progression.events.CastEvent;
	
	/**
	 * <p>InOutMovie クラスは、表示リストへの追加・削除の状態に応じたタイムラインアニメーションを実行するためのコンポーネントクラスです。
	 * このクラスを使用するためには、CommandExecutor が実装される環境設定（BasicAppConfig、WebConfig、等）を使用する必要があります。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // InOutMovie インスタンスを作成する
	 * var cast:InOutMovie = new InOutMovie();
	 * </listing>
	 */
	public class InOutMovie extends AnimationBase {
		
		/**
		 * <p>新しい InOutMovie インスタンスを作成します。</p>
		 * <p>Creates a new InOutMovie object.</p>
		 * 
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function InOutMovie( initObject:Object = null ) {
			// 親クラスを初期化する
			super( initObject );
			
			// イベントリスナーを登録する
			super.addEventListener( CastEvent.CAST_ADDED, _castAdded, false, 0, true );
			super.addEventListener( CastEvent.CAST_REMOVED, _castRemoved, false, 0, true );
		}
		
		
		
		
		
		/**
		 * <p>IExecutable オブジェクトが AddChild コマンド、または AddChildAt コマンド経由で表示リストに追加された場合に送出されます。
		 */
		private function _castAdded( e:CastEvent ):void {
			// 対象を取得する
			var target:MovieClip = super.component ? super.component.target || this : this;
			
			super.addCommand(
				new DoTweenFrame( target, "in", "stop" )
			);
		}
		
		/**
		 * <p>IExecutable オブジェクトが RemoveChild コマンド、または RemoveAllChild コマンド経由で表示リストから削除された場合に送出されます。
		 */
		private function _castRemoved( e:CastEvent ):void {
			// 対象を取得する
			var target:MovieClip = super.component ? super.component.target || this : this;
			
			super.addCommand(
				new DoTweenFrame( target, "stop", "out" )
			);
		}
	}
}
