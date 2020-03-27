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
package jp.nium.display {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.display.IExDisplayObject;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	
	/**
	 * <p>ExBitmap クラスは、Bitmap クラスの基本機能を拡張した jp.nium パッケージで使用される基本的な表示オブジェクトクラスです。</p>
	 * <p>The ExBitmap class is a basic display object class used in the jp.nium package which extends the basic function of the Bitmap class.</p>
	 * 
	 * @example <listing version="3.0" >
	 * // ExBitmap インスタンスを作成する
	 * var bmp:ExBitmap = new ExBitmap();
	 * </listing>
	 */
	public class ExBitmap extends Bitmap implements IExDisplayObject, IIdGroup {
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the IExDisplayObject.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>インスタンスの識別子を取得または設定します。</p>
		 * <p>Indicates the instance id of the IExDisplayObject.</p>
		 * 
		 * @see jp.nium.display#getInstanceById()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void {
			// 既存の登録を取得する
			var instance:IIdGroup = ExMovieClip.nium_internal::$collections.getInstanceById( value );
			
			// すでに存在していれば例外をスローする
			if ( instance ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_022 ).toString( value ) ); }
			
			// 登録する
			_id = ExMovieClip.nium_internal::$collections.registerId( this, value ) ? value : null;
		}
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the IExDisplayObject.</p>
		 * 
		 * @see jp.nium.display#getInstancesByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = ExMovieClip.nium_internal::$collections.registerGroup( this, value ) ? value : null;  }
		private var _group:String;
		
		
		
		
		
		/**
		 * <p>新しい ExBitmap インスタンスを作成します。</p>
		 * <p>Creates a new ExBitmap object.</p>
		 * 
		 * @param bitmapData
		 * <p>BitmapData オブジェクトが参照されます。</p>
		 * <p>The BitmapData object being referenced.</p>
		 * @param pixelSnapping
		 * <p>Bitmap オブジェクトが最も近いピクセルに吸着されるかどうかを示します。</p>
		 * <p>Whether or not the Bitmap object is snapped to the nearest pixel.</p>
		 * @param smoothing
		 * <p>ビットマップを拡大 / 縮小するときにスムージングするかどうかを示します。</p>
		 * <p>Whether or not the bitmap is smoothed when scaled.</p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function ExBitmap( bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false, initObject:Object = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 親クラスを初期化する
			super( bitmapData, pixelSnapping, smoothing );
			
			// コレクションに登録する
			ExMovieClip.nium_internal::$collections.addInstance( this );
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
		}
		
		
		
		
		
		/**
		 * <p>インスタンスに対して、複数のプロパティを一括設定します。</p>
		 * <p>Setup the several instance properties.</p>
		 * 
		 * @param parameters
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p>The object that contains the property to setup.</p>
		 */
		public function setProperties( parameters:Object ):void {
			ObjectUtil.setProperties( this, parameters );
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
			return ObjectUtil.formatToString( this, _classNameObj.toString(), _id ? "id" : null );
		}
	}
}
