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
	import jp.progression.core.ns.progression_internal;
	import jp.progression.Progression;
	
	/**
	 * <p>指定されたシーン識別子と同じ値が設定されている SceneObject インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.scenes.SceneObject#id
	 * 
	 * @param sceneId
	 * <p>条件となるシーン識別子です。</p>
	 * <p></p>
	 * @return
	 * <p>条件と一致するインスタンスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getSceneBySceneId( sceneId:SceneId ):SceneObject {
		// Progression インスタンスを取得する
		var prog:Progression = Progression.progression_internal::$collections.getInstanceById( sceneId.getNameByIndex( 0 ) ) as Progression;
		
		// 存在しなければ終了する
		if ( !prog ) { return null; }
		
		// ルートシーンを取得する
		var scene:SceneObject = prog.root;
		
		// シーンを検索する
		for ( var i:int = 1, l:int = sceneId.length; i < l; i++ ) {
			// シーン名を取得する
			var name:String = sceneId.getNameByIndex( i );
			
			// 子シーンを取得する
			scene = scene.getSceneByName( name );
			
			// 対象シーンが存在しなければ終了する
			if ( !scene ) { return null; }
		}
		
		return scene;
	}
}
