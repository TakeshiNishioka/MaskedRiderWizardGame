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
	
	/**
	 * <p>指定された id と同じ値が設定されている SceneObject インスタンスを返します。</p>
	 * <p></p>
	 * 
	 * @see jp.progression.scenes.SceneObject#id
	 * 
	 * @param id
	 * <p>条件となるストリングです。</p>
	 * <p></p>
	 * @return
	 * <p>条件と一致するインスタンスです。</p>
	 * <p></p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public function getSceneById( id:String ):SceneObject {
		return SceneObject.progression_internal::$collections.getInstanceById( id ) as SceneObject;
	}
}
