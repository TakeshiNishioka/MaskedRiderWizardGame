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
package jp.progression.data {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import jp.nium.collections.UniqueList;
	import jp.nium.collections.IdGroupCollection;
	import jp.nium.collections.IIdGroup;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.core.ns.progression_internal;
	
	/**
	 * <p>Resource クラスは、汎用的なリソース管理機能を提供します。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // Resource インスタンスを作成する
	 * var res:Resource = new Resource();
	 * </listing>
	 */
	public class Resource extends EventDispatcher implements IIdGroup {
		
		/**
		 * @private
		 */
		progression_internal static var $collections:IdGroupCollection = new IdGroupCollection();
		
		/**
		 * 全てのインスタンスを保存した UniqueList 配列を取得します。
		 */
		private static var _resources:UniqueList = new UniqueList();
		
		
		
		
		
		/**
		 * <p>インスタンスを表すユニークな識別子となる URL を取得または設定します。</p>
		 * <p></p>
		 * 
		 * @see jp.progression.resources#getResourceByUrl()
		 */
		public function get id():String { return _id; }
		public function set id( value:String ):void { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_013 ).toString( "id" ) ); }
		private var _id:String;
		
		/**
		 * <p>インスタンスのグループ名を取得または設定します。</p>
		 * <p>Indicates the instance group of the Resource.</p>
		 * 
		 * @see jp.progression.resources#getResourcesByGroup()
		 */
		public function get group():String { return _group; }
		public function set group( value:String ):void { _group = Resource.progression_internal::$collections.registerGroup( this, value ) ? value : null;  }
		private var _group:String;
		
		/**
		 * <p>保持しているデータを取得または設定します。</p>
		 * <p></p>
		 */
		public function get data():* { return _data; }
		public function set data( value:* ):void { _data = value; }
		private var _data:*;
		
		/**
		 * <p>読み込まれたデータの総ファイルサイズを取得します。</p>
		 * <p></p>
		 */
		public function get bytesTotal():uint { return _bytesTotal; }
		private var _bytesTotal:uint = 0;
		
		
		
		
		
		/**
		 * <p>新しい Resource インスタンスを作成します。</p>
		 * <p>Creates a new Resource object.</p>
		 * 
		 * @param url
		 * <p>データに関連付けたい URL を表すストリングです。</p>
		 * <p></p>
		 * @param data
		 * <p>保持したいデータです。</p>
		 * <p></p>
		 * @param bytesTotal
		 * <p>読み込まれたデータの総ファイルサイズです。</p>
		 * <p></p>
		 * @param initObject
		 * <p>設定したいプロパティを含んだオブジェクトです。</p>
		 * <p></p>
		 */
		public function Resource( id:String, data:*, bytesTotal:uint = 0, initObject:Object = null ) {
			// 既存の登録を取得する
			var instance:IIdGroup = Resource.progression_internal::$collections.getInstanceById( id );
			
			// すでに存在していれば
			if ( instance ) {
				Resource( instance ).dispose();
			}
			
			// 引数を設定する
			_id = id;
			_data = data;
			_bytesTotal = bytesTotal;
			
			// コレクションに登録する
			Resource.progression_internal::$collections.addInstance( this );
			if ( !Resource.progression_internal::$collections.registerId( this, id ) ) {
				_id = null;
			}
			_resources.addItem( this );
			
			// 初期化する
			ObjectUtil.setProperties( this, initObject );
		}
		
		
		
		
		
		/**
		 * <p>保持しているデータを解放します。
		 * dispose() メソッドが呼び出されると、それ以降はこのインスタンスのメソッドまたはプロパティを呼び出すと失敗し、例外がスローされます。</p>
		 * <p></p>
		 */
		public function dispose():void {
			// 登録を解除する
			Resource.progression_internal::$collections.registerId( this, null );
			_resources.removeItem( this );
			
			// データを破棄する
			_id = null;
			_group = null;
			_data = null;
			_bytesTotal = 1;
		}
		
		/**
		 * <p>指定されたオブジェクトの BitmapData 表現を返します。</p>
		 * <p>Returns the BitmapData representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの BitmapData 表現です。</p>
		 * <p>A BitmapData representation of the object.</p>
		 */
		public function toBitmapData():BitmapData {
			return _data as BitmapData;
		}
		
		/**
		 * <p>指定されたオブジェクトの Loader 表現を返します。</p>
		 * <p>Returns the Loader representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの Loader 表現です。</p>
		 * <p>A Loader representation of the object.</p>
		 */
		public function toLoader():Loader {
			return _data as Loader;
		}
		
		/**
		 * <p>指定されたオブジェクトの Sound 表現を返します。</p>
		 * <p>Returns the Sound representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの Sound 表現です。</p>
		 * <p>A Sound representation of the object.</p>
		 */
		public function toSound():Sound {
			return _data as Sound;
		}
		
		/**
		 * <p>指定されたオブジェクトの XML 表現を返します。</p>
		 * <p>Returns the XML representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトの XML 表現です。</p>
		 * <p>A XML representation of the object.</p>
		 */
		public function toXML():XML {
			return _data as XML;
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
			return _data.toString();
		}
	}
}
