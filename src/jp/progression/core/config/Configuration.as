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
package jp.progression.core.config {
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.progression.data.DataHolder;
	import jp.progression.executors.ExecutorObject;
	
	/**
	 * @private
	 */
	public class Configuration {
		
		/**
		 * <p>インスタンスのクラス名を取得します。</p>
		 * <p>Indicates the instance className of the Configuration.</p>
		 */
		public function get className():String { return _classNameObj ? _classNameObj.toString() : ClassUtil.nium_internal::$DEFAULT_CLASS_NAME; }
		private var _classNameObj:StringObject;
		
		/**
		 * <p>初期化処理の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get initializer():Class { return _initializer; }
		private var _initializer:Class;
		
		/**
		 * <p>シンクロナイザの実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get synchronizer():Class { return _synchronizer; }
		private var _synchronizer:Class;
		
		/**
		 * <p>汎用的な処理の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get executor():Class { return _executor || ExecutorObject; }
		private var _executor:Class;
		
		/**
		 * <p>キーボード処理の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get keyboardMapper():Class { return _keyboardMapper; }
		private var _keyboardMapper:Class;
		
		/**
		 * <p>コンテクストメニュー処理の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get contextMenuBuilder():Class { return _contextMenuBuilder; }
		private var _contextMenuBuilder:Class;
		
		/**
		 * <p>ツールチップ処理の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get toolTipRenderer():Class { return _toolTipRenderer; }
		private var _toolTipRenderer:Class;
		
		/**
		 * <p>データ管理機能の実装として使用したいクラスを取得します。</p>
		 * <p></p>
		 */
		public function get dataHolder():Class { return _dataHolder || DataHolder; }
		private var _dataHolder:Class;
		
		
		
		
		
		/**
		 * <p>新しい Configuration インスタンスを作成します。</p>
		 * <p>Creates a new Configuration object.</p>
		 * 
		 * @param initializer
		 * <p>イニシャライザの実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param synchronizer
		 * <p>シンクロナイザの実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param executor
		 * <p>汎用的な処理の実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param keyboardMapper
		 * <p>キーボード処理の実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param contextMenuBuilder
		 * <p>コンテクストメニュー処理の実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param toolTipRenderer
		 * <p>ツールチップ処理の実装として使用したいクラスです。</p>
		 * <p></p>
		 * @param dataHolder
		 * <p>データ管理機能の実装として使用したいクラスです。</p>
		 * <p></p>
		 */
		public function Configuration( initializer:Class = null, synchronizer:Class = null, executor:Class = null, keyboardMapper:Class = null, contextMenuBuilder:Class = null, toolTipRenderer:Class = null, dataHolder:Class = null ) {
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 親クラスを初期化する
			super();
			
			// 引数を設定する
			_initializer = initializer;
			_synchronizer = synchronizer;
			_executor = executor;
			_keyboardMapper = keyboardMapper;
			_contextMenuBuilder = contextMenuBuilder;
			_toolTipRenderer = toolTipRenderer;
			_dataHolder = dataHolder;
		}
		
		
		
		
		
		/**
		 * <p>指定されたオブジェクトのストリング表現を返します。</p>
		 * <p>Returns the string representation of the specified object.</p>
		 * 
		 * @return
		 * <p>オブジェクトのストリング表現です。</p>
		 * <p>A string representation of the object.</p>
		 */
		public function toString():String {
			return ObjectUtil.formatToString( this, _classNameObj.toString() );
		}
	}
}
