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
package jp.progression.commands.tweens {
	import caurina.transitions.Tweener;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.commands.Command;
	
	/**
	 * <p>DoTweener クラスは、caurina.transitions.Tweener パッケージのイージング機能を実行するコマンドクラスです。</p>
	 * <p></p>
	 * 
	 * @see http://code.google.com/p/tweener/
	 * @see http://code.google.com/p/tweener/wiki/License
	 * 
	 * @example <listing version="3.0" >
	 * // DoTweener インスタンスを作成する
	 * var com:DoTweener = new DoTweener();
	 * 
	 * // コマンドを実行する
	 * com.execute();
	 * </listing>
	 */
	public class DoTweener extends Command {
		
		/**
		 * <p></p>
		 * <p>Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</p>
		 */
		public function get target():Object { return _target; }
		private var _target:Object;
		
		/**
		 * <p></p>
		 * <p>An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</p>
		 */
		public function get parameters():Object { return _parameters; }
		private var _parameters:Object;
		
		/**
		 * 
		 */
		private var _executingParams:Object;
		
		/**
		 * 実行前のパラメータを取得します。
		 */
		private var _before:Object;
		
		
		
		
		
		/**
		 * <p>新しい DoTweener インスタンスを作成します。</p>
		 * <p>Creates a new DoTweener object.</p>
		 * 
		 * @param target
		 * <p></p>
		 * <p>Any object that will suffer a tweening. These objects are usually MovieClip, TextField, or Sound instances, or any other custom object with a numeric property that needs to be tweened.</p>
		 * @param tweeningParameters
		 * <p></p>
		 * <p>An object containing various properties of the original object that you want to tween on the original objects, with their final values assigned (some special properties are also allowed), as well as some built-in Tweener properties used when defining tweening parameters. This is like the recipe for the tweening, declaring both what will be tweened, and how.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function DoTweener( target:Object, parameters:Object, initObject:Object = null ) {
			// 引数を設定する
			_target = target;
			_parameters = parameters || {};
			
			// 親クラスを初期化する
			super( _executeFunction, _interruptFunction, initObject );
		}
		
		
		
		
		
		/**
		 * 実行されるコマンドの実装です。
		 */
		private function _executeFunction():void {
			// 現在の状態を保存する
			_before = {};
			_executingParams = {};
			for ( var p:String in _parameters ) {
				_executingParams[p] = _parameters[p];
				if ( p in _target ) {
					_before[p] = _target[p];
				}
			}
			
			// 初期化する
			_parameters.onComplete = _onComplete;
			_parameters.onError = _onError;
			delete _parameters.onStart;
			delete _parameters.onOverwrite;
			delete _parameters.onUpdate;
			
			// 実行する
			Tweener.addTween( _target, _parameters );
		}
		
		/**
		 * 
		 */
		private function _onComplete():void {
			// 初期状態を破棄する
			_before = null;
			_executingParams = null;
			
			// 処理を終了する
			super.executeComplete();
		}
		
		/**
		 * 
		 */
		private function _onError( errorScope:Object, metaError:Error ):void {
			errorScope;
			
			// 初期状態を破棄する
			_before = null;
			_executingParams = null;
			
			// 例外をスローする
			super.throwError( this, metaError );
		}
		
		/**
		 * 中断実行されるコマンドの実装です。
		 */
		private function _interruptFunction():void {
			// 実行中のパラメータを取得する
			var params:Array = [ _target ];
			for ( var p:String in _executingParams ) {
				params.push( p );
			}
			
			// 中断する
			try {
				Tweener.removeTweens.apply( null, params );
			}
			catch ( e:Error ) {}
			
			// 実行時間を 0 にする
			_before.time = 0;
			_executingParams.time = 0;
			
			// 中断方法によって処理を振り分ける
			switch ( interruptType ) {
				case 0	: { Tweener.addTween( _target, _before ); break; }
				case 2	: { Tweener.addTween( _target, _executingParams ); break; }
			}
			
			// 初期状態を破棄する
			_before = null;
			_executingParams = null;
		}
		
		/**
		 * <p>DoTweener インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an DoTweener subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい DoTweener インスタンスです。</p>
		 * <p>A new DoTweener object that is identical to the original.</p>
		 */
		public override function clone():Command {
			return new DoTweener( _target, _parameters, this );
		}
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public override function toString():String {
			return ObjectUtil.formatToString( this, super.className, super.id ? "id" : null, "target" );
		}
	}
}
