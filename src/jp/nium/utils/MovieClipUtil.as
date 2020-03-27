/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2009 taka:nium.jp, All Rights Reserved.
 * @version 4.0.1 Public Beta 1.2
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package jp.nium.utils {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <p>MovieClipUtil クラスは、MovieClip 操作のためのユーティリティクラスです。</p>
	 * <p>The MovieClipUtil class is an utility class for MovieClip operation.</p>
	 */
	public class MovieClipUtil {
		
		/**
		 * 
		 */
		private static var _movieClip:MovieClip = new MovieClip();
		
		
		
		
		
		/**
		 * @private
		 */
		public function MovieClipUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <p>MovieClip インスタンスの指定されたフレームラベルからフレーム番号を保持した配列を取得します。</p>
		 * <p>Get the array which contains the frame number that specified by frame label of the MovieClip instance.</p>
		 * 
		 * @param movie
		 * <p>フレーム番号を取得したい MovieClip インスタンスです。</p>
		 * <p>The MovieClip instance to get the frame number.</p>
		 * @param labelName
		 * <p>フレームラベルです。</p>
		 * <p>The frame label.</p>
		 * @return
		 * <p>フレーム番号です。</p>
		 * <p>The frame number.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function labelToFrames( movie:MovieClip, labelName:String ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			for ( var i:int = 0, l:int = labels.length; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( labelName == frameLabel.name ) { list.push( frameLabel.frame ); }
			}
			
			return list;
		}
		
		/**
		 * <p>MovieClip インスタンスの指定されたフレーム番号からフレームラベルを保持した配列を取得します。</p>
		 * <p>Get the array which contains the frame label that specified by frame number of the MovieClip instance.</p>
		 * 
		 * @param movie
		 * <p>フレームラベルを取得したい MovieClip インスタンスです。</p>
		 * <p>The MovieClip instance to get the frame number.</p>
		 * @param labelName
		 * <p>フレーム番号です。</p>
		 * <p>The frame number.</p>
		 * @return
		 * <p>フレームラベルです。</p>
		 * <p>The frame label.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function frameToLabels( movie:MovieClip, frame:int ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			for ( var i:int = 0, l:int = labels.length; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( frame == frameLabel.frame ) { list.push( frameLabel.name ); }
			}
			
			return list;
		}
		
		/**
		 * <p>指定された 2 点間のフレーム差を取得します。</p>
		 * <p>Get the frame difference of specified two points.</p>
		 * 
		 * @param movie
		 * <p>対象の MovieClip インスタンスです。</p>
		 * <p>The MovieClip instance to process.</p>
		 * @param frame1
		 * <p>最初のフレーム位置です。</p>
		 * <p>The position of the first frame.</p>
		 * @param frame2
		 * <p>2 番目のフレーム位置です。</p>
		 * <p>The position of the second frame.<.p>
		 * @return
		 * <p>フレーム差です。</p>
		 * <p>The frame difference.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function getDistanceFrames( movie:MovieClip, frame1:*, frame2:* ):int {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			
			return Math.abs( e - s );
		}
		
		/**
		 * <p>指定されて 2 点間に再生ヘッドが存在しているかどうかを取得します。</p>
		 * <p>Returns if the playback head exists between the specified two points.</p>
		 * 
		 * @param movie
		 * <p>対象の MovieClip インスタンスです。</p>
		 * <p>The MovieClip instance to process.</p>
		 * @param frame1
		 * <p>最初のフレーム位置です。</p>
		 * <p>The position of the first frame.</p>
		 * @param frame2
		 * <p>2 番目のフレーム位置です。</p>
		 * <p>The position of the second frame.<.p>
		 * @return
		 * <p>存在していれば true 、なければ false です。</p>
		 * <p>Returns true if exists, otherwise return false.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function playheadWithinFrames( movie:MovieClip, frame1:*, frame2:* ):Boolean {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			var c:int = movie.currentFrame;
			
			// s の方が e よりも大きい場合に入れ替える
			if ( s > e ) {
				var temp:int = s;
				s = e;
				e = temp;
			}
			
			return ( s <= c && c <= e );
		}
		
		/**
		 * <p>指定したフレームが存在しているかどうかを返します。</p>
		 * <p>Returns if the specified frame exists.</p>
		 * 
		 * @param movie
		 * <p>対象の MovieClip インスタンスです。</p>
		 * <p>The MovieClip instance to process.</p>
		 * @param labelName
		 * <p>存在を確認するフレームです。</p>
		 * <p>The frame to check if exists.</p>
		 * @return
		 * <p>存在していれば true 、なければ false です。</p>
		 * <p>Returns true if exists, otherwise return false.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function hasFrame( movie:MovieClip, frame:* ):Boolean {
			var frameNum:int = _getFrame( movie, frame );
			return ( 0 < frameNum && frameNum <= movie.totalFrames );
		}
		
		/**
		 * 対象の MovieClip インスタンスに存在するフレームラベルを保持した配列を返します。
		 */
		private static function _getFrameLabels( movie:MovieClip ):Array {
			var list:Array = [];
			
			// Scene を取得する
			var scenes:Array = movie.scenes;
			for ( var i:int = 0, l:int = scenes.length; i < l; i++ ) {
				// 参照を取得する
				var scene:Scene = Scene( scenes[i] );
				var labels:Array = scene.labels;
				
				// FrameLabel を取得する
				for ( var ii:int = 0, ll:int = labels.length; ii < ll; ii++ ) {
					list.push( labels[ii] );
				}
			}
			
			return list;
		}
		
		/**
		 * 対象の MovieClip に存在する指定された位置のフレーム番号を返します。
		 */
		private static function _getFrame( movie:MovieClip, frame:* ):int {
			switch ( true ) {
				case frame is String	: { return labelToFrames( movie, frame )[0]; }
				case frame is int		: { return frame; }
			}
			return -1;
		}
		
		/**
		 * <p>指定された関数を 1 フレーム経過後に実行します。</p>
		 * <p>Execute the specified function, 1 frame later.</p>
		 * 
		 * @param scope
		 * <p>関数が実行される際のスコープです。</p>
		 * <p>The scope when the function executes.</p>
		 * @param callBack
		 * <p>実行したい関数です。</p>
		 * <p>The function to execute.</p>
		 * @param args
		 * <p>関数の実行時の引数です。</p>
		 * <p>The argument of the function when executes.</p>
		 * 
		 * @example <listing version="3.0" >
		 * </listing>
		 */
		public static function doLater( scope:*, callBack:Function, ... args:Array ):void {
			var timer:Timer = new Timer( 1, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, function( e:TimerEvent ):void {
				// イベントリスナーを解除する
				Timer( e.target ).removeEventListener( e.type, arguments.callee );
				
				// コールバック関数を実行する
				callBack.apply( scope, args );
			} );
			timer.start();
		}
		
		/**
		 * <p>Event.ENTER_FRAME のイベントに対してリスナーを登録します。</p>
		 * <p></p>
		 * 
		 * @param listener
		 * <p>イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</p>
		 * <p>The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</p>
		 * <p>Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</p>
		 * @param priority
		 * <p>イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</p>
		 * <p>The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</p>
		 * @param useWeakReference
		 * <p>リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</p>
		 * <p>Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</p>
		 */
		public static function addEnterFrameListener( listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_movieClip.addEventListener( Event.ENTER_FRAME, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <p>Event.ENTER_FRAME のイベントに対して登録したリスナーを解除します。</p>
		 * <p></p>
		 * 
		 * @param listener
		 * <p>削除するリスナーオブジェクトです。</p>
		 * <p>The listener object to remove.</p>
		 * @param useCapture
		 * <p>リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</p>
		 * <p>Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</p>
		 */
		public static function removeEnterFrameListener( listener:Function, useCapture:Boolean = false ):void {
			_movieClip.removeEventListener( Event.ENTER_FRAME, listener, useCapture );
		}
	}
}
