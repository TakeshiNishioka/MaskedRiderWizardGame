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
package jp.progression.scenes {
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.net.Query;
	
	/**
	 * <p>SceneId クラスは、シーンオブジェクト構造上の特定のシーンを表すモデルクラスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * // SceneId インスタンスを作成する
	 * var sceneId:SceneId = new SceneId();
	 * </listing>
	 */
	public class SceneId {
		
		/**
		 * <p>非 SceneId の値を表す SceneId 型の特殊なメンバーを取得します。</p>
		 * <p></p>
		 */
		public static const NaS:SceneId = new SceneId( "NaS" );
		
		/**
		 * シーン名の書式を確認するための正規表現を取得します。
		 */
		private static const _VALIDATE_NAME_REGEXP:String = "[\\w][-.,&%+\\w]*[\\w]?";
		
		/**
		 * シーンパスの書式を確認するための正規表現を取得します。
		 */
		private static const _VALIDATE_PATH_REGEXP:String = "(/" + _VALIDATE_NAME_REGEXP + "(/\\.{1,2})*)*(/" + _VALIDATE_NAME_REGEXP + ")/?(\\?(" + _VALIDATE_NAME_REGEXP + "+=" + _VALIDATE_NAME_REGEXP + "+)(&(" + _VALIDATE_NAME_REGEXP + "+=" + _VALIDATE_NAME_REGEXP + "+))*)?";
		
		
		
		
		
		/**
		 * <p>シーンパスを取得します。</p>
		 * <p></p>
		 */
		public function get path():String { return _path; }
		private var _path:String;
		
		/**
		 * <p>シーンパスの深度を取得します。</p>
		 * <p></p>
		 */
		public function get length():int { return _length; }
		private var _length:int = 0;
		
		/**
		 * <p>シーンパスに関連付けられているクエリオブジェクトを取得します。</p>
		 * <p></p>
		 */
		public function get query():Query { return _query; }
		private var _query:Query;
		
		/**
		 * Not a SceneId であるかどうかを取得します。
		 */
		private var _isNaS:Boolean = false;
		
		
		
		
		
		/**
		 * <p>新しい SceneId インスタンスを作成します。</p>
		 * <p>Creates a new SceneId object.</p>
		 * 
		 * @param scenePath
		 * <p>シーン識別子に変換するシーンパス、または URL を表すストリングです。</p>
		 * <p></p>
		 * @param query
		 * <p>シーンパスに付加されるクエリです。</p>
		 * <p></p>
		 */
		public function SceneId( scenePath:String, query:* = null ) {
			// NaS が未作成状態であれば
			if ( !NaS ) {
				_path = scenePath;
				_length = -1;
				_isNaS = true;
				return;
			}
			
			// シーンパスを再エンコードする
			scenePath = encodeURI( decodeURI( scenePath ) );
			
			// シーンパスの書式が正しくなければ例外をスローする
			if ( !validatePath( scenePath ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_005 ).toString( "scenePath" ) ); }
			
			// 引数を設定する
			var segments:Array = scenePath.split( "?" );
			
			// 引数を設定する
			_path = _normalize( segments[0] );
			_query = new Query( query || segments[1], true );
			
			// 初期化する
			_length = _path.split( "/" ).length - 1;
		}
		
		
		
		
		
		/**
		 * <p>シーン名の書式が正しいかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @see #validatePath()
		 * 
		 * @param name
		 * <p>書式を調べるシーン名です。</p>
		 * <p></p>
		 * @return
		 * <p>書式が正しければ true に、それ以外の場合は false になります。</p>
		 * <p></p>
		 */
		public static function validateName( name:String ):Boolean {
			return new RegExp( "^" + _VALIDATE_NAME_REGEXP + "$", "i" ).test( name );
		}
		
		/**
		 * <p>シーンパスの書式が正しいかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @see #validateName()
		 * 
		 * @param path
		 * <p>書式を調べるシーンパスです。</p>
		 * <p></p>
		 * @return
		 * <p>書式が正しければ true に、それ以外の場合は false になります。</p>
		 * <p></p>
		 */
		public static function validatePath( path:String ):Boolean {
			return new RegExp( "^" + _VALIDATE_PATH_REGEXP + "$", "i" ).test( path );
		}
		
		/**
		 * <p>対象のシーン識別子が NaS であるかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @see NaS
		 * 
		 * @param sceneId
		 * <p>比較対象の値です。</p>
		 * <p></p>
		 * @return
		 * <p>対象が NaS であれば true を、それ以外は false を返します。</p>
		 * <p></p>
		 */
		public static function isNaS( sceneId:SceneId ):Boolean {
			return ( NaS == sceneId );
		}
		
		
		
		
		
		/**
		 * <p>指定された絶対シーンパスもしくは相対シーンパスを使用して移動後のシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</p>
		 * <p></p>
		 * 
		 * @param path
		 * <p>移動先のシーンパスです。</p>
		 * <p></p>
		 * @param query
		 * <p>移動後のシーンパスに付加されるクエリです。</p>
		 * <p></p>
		 * @return
		 * <p>移動後のシーン識別子です。</p>
		 * <p></p>
		 */
		public function transfer( scenePath:String, query:* = null ):SceneId {
			// Not a SceneId であれば
			if ( _isNaS ) { return this; }
			
			// 相対パスの場合、既存のパスに結合する
			if ( scenePath.charAt( 0 ) != "/" ) {
				scenePath = _path + "/" + scenePath;
			}
			
			// フォーマットを正規化する
			scenePath = _normalize( scenePath );
			
			// 書式が正しくない場合例外をスローする
			if ( !validatePath( scenePath ) ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_004 ).toString( "scenePath" ) ); }
			
			// query が存在すれば
			query &&= new Query( query, true );
			
			return new SceneId( scenePath, query );
		}
		
		/**
		 * <p>シーン識別子の保存するシーンパスの指定された範囲のエレメントを取り出して、新しいシーン識別子を返します。
		 * この操作で元のシーン識別子は変更されません。</p>
		 * <p></p>
		 * 
		 * @param startIndex
		 * <p>スライスの始点のインデックスを示す数値です。</p>
		 * <p></p>
		 * @param endIndex
		 * <p>スライスの終点のインデックスを示す数値です。このパラメータを省略すると、スライスには配列の最初から最後までのすべてのエレメントが取り込まれます。endIndex が負の数値の場合、終点は配列の末尾から開始します。つまり、-1 が最後のエレメントです。</p>
		 * <p></p>
		 * @return
		 * <p>元のシーンパスから取り出した一連のエレメントから成るシーン識別子です。</p>
		 * <p></p>
		 */
		public function slice( startIndex:int = 0, endIndex:int = 0x7FFFFFFF ):SceneId {
			// Not a SceneId であれば
			if ( _isNaS ) { return this; }
			
			if ( endIndex - startIndex == 0 ) { throw new Error( Logger.getLog( L10NNiumMsg.ERROR_012 ).toString( startIndex, endIndex ) ); }
			
			var dir:Array = _path.split( "/" );
			dir.shift();
			
			dir = dir.slice( Math.min( dir.length - 1, startIndex ), endIndex );
			
			return new SceneId( "/" + dir.join( "/" ), _query );
		}
		
		/**
		 * <p>指定されたシーン識別子が、自身の表すシーンパスの子シーンオブジェクトを指しているかどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param sceneId
		 * <p>テストするシーン識別子です。</p>
		 * <p></p>
		 * @return
		 * <p>子シーンオブジェクトを指していれば true に、それ以外の場合は false になります。</p>
		 * <p></p>
		 */
		public function contains( sceneId:SceneId ):Boolean {
			// Not a SceneId であれば
			if ( _isNaS || sceneId._isNaS ) { return false; }
			
			// パスを取得する
			var path1:Array = _path.split( "/" );
			var path2:Array = sceneId._path.split( "/" );
			
			for ( var i:int = 0, l:int = path1.length; i < l; i++ ) {
				if ( path1[i] != path2[i] ) { return false; }
			}
			
			return true;
		}
		
		/**
		 * <p>指定されたシーン識別子が、自身の表すシーンパスと同一かどうかを返します。</p>
		 * <p></p>
		 * 
		 * @param sceneId
		 * <p>テストするシーン識別子です。</p>
		 * <p></p>
		 * @param matchQuery
		 * <p>テストにクエリの値を含めるかどうかです。</p>
		 * <p></p>
		 * @return
		 * <p>同一のシーンパスを指していれば true に、それ以外の場合は false になります。</p>
		 * <p></p>
		 */
		public function equals( sceneId:SceneId, matchQuery:Boolean = false ):Boolean {
			// NaS であれば
			if ( _isNaS || sceneId._isNaS ) { return ( sceneId == this ); }
			
			// 片方のみ存在するのであれば
			if ( !_query == !!sceneId._query ) { return false; }
			
			// クエリが一致していなければ false を返す
			if ( matchQuery && _query && !_query.equals( sceneId._query ) ) { return false; }
			
			return ( _path == sceneId._path );
		}
		
		/**
		 * <p>指定位置にあるシーンの名前を返します。</p>
		 * <p></p>
		 * 
		 * @param index
		 * <p>取得した名前のあるシーンの位置です。</p>
		 * <p></p>
		 * @return
		 * <p>指定位置にあるシーンの名前です。</p>
		 * <p></p>
		 */
		public function getNameByIndex( index:int ):String {
			// Not a SceneId であれば
			if ( _isNaS ) { return ""; }
			
			var dir:Array = _path.split( "/" );
			dir.shift();
			
			// マイナスが指定されたら、最後尾からのインデックスを取得する
			if ( index < 0 ) {
				index += dir.length;
			}
			
			return dir[index];
		}
		
		/**
		 * 
		 */
		private function _normalize( scenePath:String ):String {
			// パスの末尾が / であれば削除する
			var results:Array = new RegExp( "^(/" + _VALIDATE_NAME_REGEXP + "+(/" + _VALIDATE_NAME_REGEXP + "+)*)/$" ).exec( scenePath );
			if ( results ) {
				scenePath = results[1];
			}
			
			// パスに /./ が存在すれば結合する
			scenePath = scenePath.replace( new RegExp( "/\\./", "g" ), "/" );
			
			// /A/B/../ なら /A/ に変換する
			var regExp:String = "(/" + _VALIDATE_NAME_REGEXP + "+/)" + _VALIDATE_NAME_REGEXP + "+/\\.{2}/";
			while ( new RegExp( regExp, "gi" ).test( scenePath ) ) {
				scenePath = scenePath.replace( new RegExp( regExp, "gi" ), function():String { return arguments[1]; } );
			}
			
			// /A/../B なら /B に変換する
			regExp = "/" + _VALIDATE_NAME_REGEXP + "+/\\.{2}(/" + _VALIDATE_NAME_REGEXP + "+)";
			while ( new RegExp( regExp, "gi" ).test( scenePath ) ) {
				scenePath = scenePath.replace( new RegExp( regExp, "gi" ), function():String { return arguments[1]; } );
			}
			
			// 末尾の /../ を削除する
			regExp = "/\\.{2}/?$";
			while ( new RegExp( regExp, "gi" ).test( scenePath ) ) {
				scenePath = scenePath.replace( new RegExp( regExp, "g" ), "" );
			}
			
			return scenePath;
		}
		
		/**
		 * <p>SceneId インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</p>
		 * <p>Duplicates an instance of an SceneId subclass.</p>
		 * 
		 * @return
		 * <p>元のオブジェクトと同じプロパティ値を含む新しい SceneId インスタンスです。</p>
		 * <p>A new SceneId object that is identical to the original.</p>
		 */
		public function clone():SceneId {
			// Not a SceneId であれば
			if ( _isNaS ) { return this; }
			
			return new SceneId( _path, _query );
		}
		
		/**
		 * <p>同期時に使用されるルートを省略したショートパスを表すストリングを返します。</p>
		 * <p></p>
		 * 
		 * @return
		 * <p>ショートパスを表すストリングです。</p>
		 * <p></p>
		 */
		public function toShortPath():String {
			// Not a SceneId であれば
			if ( _isNaS ) { return "NaS"; }
			
			// クエリストリングを取得する
			var query:String = _query ? _query.toString() : "";
			query &&= "?" + query;
			
			return ( _length > 1 ? slice( 1 ).path : "" ) + query;
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
			// Not a SceneId であれば
			if ( _isNaS ) { return "NaS"; }
			
			// クエリストリングを取得する
			var query:String = _query ? _query.toString() : "";
			query &&= "?" + query;
			
			return _path + query;
		}
	}
}
