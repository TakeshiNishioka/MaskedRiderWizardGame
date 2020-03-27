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
package jp.nium.impls {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	/**
	 * <p><p>
	 * <p><p>
	 * 
	 * @example <listing version="3.0" >
	 * </listing>
	 */
	public interface ITextField extends IInteractiveObject {
		
		/**
		 * <p>true に設定され、テキストフィールドにフォーカスがない場合、テキストフィールド内の選択内容は灰色でハイライト表示されます。</p>
		 * <p>When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.</p>
		 */
		function get alwaysShowSelection():Boolean;
		function set alwaysShowSelection( value:Boolean ):void;
		
		/**
		 * <p>このテキストフィールドに使用されるアンチエイリアス処理のタイプです。</p>
		 * <p>The type of anti-aliasing used for this text field.</p>
		 */
		function get antiAliasType():String;
		function set antiAliasType( value:String ):void;
		
		/**
		 * <p>テキストフィールドの自動的な拡大 / 縮小および整列を制御します。</p>
		 * <p>Controls automatic sizing and alignment of text fields.</p>
		 */
		function get autoSize():String;
		function set autoSize( value:String ):void;
		
		/**
		 * <p>テキストフィールドに背景の塗りがあるかどうかを指定します。</p>
		 * <p>Specifies whether the text field has a background fill.</p>
		 */
		function get background():Boolean;
		function set background( value:Boolean ):void;
		
		/**
		 * <p>テキストフィールドの背景の色です。</p>
		 * <p>The color of the text field background.</p>
		 */
		function get backgroundColor():uint;
		function set backgroundColor( value:uint ):void;
		
		/**
		 * <p>テキストフィールドに境界線があるかどうかを指定します。</p>
		 * <p>Specifies whether the text field has a border.</p>
		 */
		function get border():Boolean;
		function set border( value:Boolean ):void;
		
		/**
		 * <p>テキストフィールドの境界線の色です。</p>
		 * <p>The color of the text field border.</p>
		 */
		function get borderColor():uint;
		function set borderColor( value:uint ):void;
		
		/**
		 * <p>指定されたテキストフィールドの現在の表示範囲で最終行を示す整数です（1 から始まるインデックス）。</p>
		 * <p>An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.</p>
		 */
		function get bottomScrollV():int;
		
		/**
		 * <p>カーソル（キャレット）位置のインデックスです。</p>
		 * <p>The index of the insertion point (caret) position.</p>
		 */
		function get caretIndex():int;
		
		/**
		 * <p>HTML テキストが含まれるテキストフィールド内の余分な空白（スペース、改行など）を削除するかどうかを指定するブール値です。</p>
		 * <p>A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.</p>
		 */
		function get condenseWhite():Boolean;
		function set condenseWhite( value:Boolean ):void;
		
		/**
		 * <p>新しく挿入するテキスト (ユーザーが入力したテキストや replaceSelectedText() メソッドで挿入したテキストなど) に適用するフォーマットを指定します。</p>
		 * <p>Specifies the format applied to newly inserted text, such as text entered by a user or text inserted with the replaceSelectedText() method.</p>
		 */
		function get defaultTextFormat():TextFormat;
		function set defaultTextFormat( value:TextFormat ):void;
		
		/**
		 * <p>テキストフィールドがパスワードテキストフィールドであるかどうかを指定します。</p>
		 * <p>Specifies whether the text field is a password text field.</p>
		 */
		function get displayAsPassword():Boolean;
		function set displayAsPassword( value:Boolean ):void;
		
		/**
		 * <p>埋め込みフォントのアウトラインを使用してレンダリングするかどうかを指定します。</p>
		 * <p>Specifies whether to render by using embedded font outlines.</p>
		 */
		function get embedFonts():Boolean;
		function set embedFonts( value:Boolean ):void;
		
		/**
		 * <p>このテキストフィールドに使用されるグリッドフィッティングのタイプです。</p>
		 * <p>The type of grid fitting used for this text field.</p>
		 */
		function get gridFitType():String;
		function set gridFitType( value:String ):void;
		
		/**
		 * <p>テキストフィールドの内容を HTML で表します。</p>
		 * <p>Contains the HTML representation of the text field contents.</p>
		 */
		function get htmlText():String;
		function set htmlText( value:String ):void;
		
		/**
		 * <p>テキストフィールド内の文字数です。</p>
		 * <p>The number of characters in a text field.</p>
		 */
		function get length():int;
		
		/**
		 * <p>ユーザーが入力するときに、テキストフィールドに入力できる最大の文字数です。</p>
		 * <p>The maximum number of characters that the text field can contain, as entered by a user.</p>
		 */
		function get maxChars():int;
		function set maxChars( value:int ):void;
		
		/**
		 * <p>scrollH の最大値です。</p>
		 * <p>The maximum value of scrollH.</p>
		 */
		function get maxScrollH():int;
		
		/**
		 * <p>scrollV の最大値です。</p>
		 * <p>The maximum value of scrollV.</p>
		 */
		function get maxScrollV():int;
		
		/**
		 * <p>複数行にわたるテキストフィールドで、ユーザーがテキストフィールドをクリックしてホイールを回転させると、自動的にスクロールするかどうかを示すブール値です。</p>
		 * <p>A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.</p>
		 */
		function get mouseWheelEnabled():Boolean;
		function set mouseWheelEnabled( value:Boolean ):void;
		
		/**
		 * <p>フィールドが複数行テキストフィールドであるかどうかを示します。</p>
		 * <p>Indicates whether field is a multiline text field.</p>
		 */
		function get multiline():Boolean;
		function set multiline( value:Boolean ):void;
		
		/**
		 * <p>複数行テキストフィールド内のテキスト行の数を定義します。</p>
		 * <p>Defines the number of text lines in a multiline text field.</p>
		 */
		function get numLines():int;
		
		/**
		 * <p>ユーザーがテキストフィールドに入力できる文字のセットを指定します。</p>
		 * <p>Indicates the set of characters that a user can enter into the text field.</p>
		 */
		function get restrict():String;
		function set restrict( value:String ):void;
		
		/**
		 * <p>現在の水平スクロール位置です。</p>
		 * <p>The current horizontal scrolling position.</p>
		 */
		function get scrollH():int;
		function set scrollH( value:int ):void;
		
		/**
		 * <p>テキストフィールドのテキストの垂直位置です。</p>
		 * <p>The vertical position of text in a text field.</p>
		 */
		function get scrollV():int;
		function set scrollV( value:int ):void;
		
		/**
		 * <p>テキストフィールドが選択可能であるかどうかを示すブール値です。</p>
		 * <p>A Boolean value that indicates whether the text field is selectable.</p>
		 */
		function get selectable():Boolean;
		function set selectable( value:Boolean ):void;
		
		/**
		 * <p>現在の選択範囲の最初の文字を示す、0 から始まるインデックス値です。</p>
		 * <p>The zero-based character index value of the first character in the current selection.</p>
		 */
		function get selectionBeginIndex():int;
		
		/**
		 * <p>現在の選択範囲における最後の文字を示す、0 から始まるインデックス値です。</p>
		 * <p>The zero-based character index value of the last character in the current selection.</p>
		 */
		function get selectionEndIndex():int;
		
		/**
		 * <p>このテキストフィールド内の文字エッジのシャープネスです。</p>
		 * <p>The sharpness of the glyph edges in this text field.</p>
		 */
		function get sharpness():Number;
		function set sharpness( value:Number ):void;
		
		/**
		 * <p>テキストフィールドにスタイルシートを関連付けます。</p>
		 * <p>Attaches a style sheet to the text field.</p>
		 */
		function get styleSheet():StyleSheet;
		function set styleSheet( value:StyleSheet ):void;
		
		/**
		 * <p>テキストフィールド内の現在のテキストであるストリングです。</p>
		 * <p>A string that is the current text in the text field.</p>
		 */
		function get text():String;
		function set text( value:String ):void;
		
		/**
		 * <p>テキストフィールドのテキストの色です（16 進数形式）。</p>
		 * <p>The color of the text in a text field, in hexadecimal format.</p>
		 */
		function get textColor():uint;
		function set textColor( value:uint ):void;
		
		/**
		 * <p>テキストの高さです（ピクセル単位）。</p>
		 * <p>The height of the text in pixels.</p>
		 */
		function get textHeight():Number;
		
		/**
		 * <p>テキストの幅です（ピクセル単位）。</p>
		 * <p>The width of the text in pixels.</p>
		 */
		function get textWidth():Number;
		
		/**
		 * <p>このテキストフィールド内の文字エッジの太さです。</p>
		 * <p>The thickness of the glyph edges in this text field.</p>
		 */
		function get thickness():Number;
		function set thickness( value:Number ):void;
		
		/**
		 * <p>テキストフィールドのタイプです。</p>
		 * <p>The type of the text field.</p>
		 */
		function get type():String;
		function set type( value:String ):void;
		
		/**
		 * <p>テキストと共にテキストのフォーマットをコピー＆ペーストするかどうかを指定します。</p>
		 * <p>Specifies whether to copy and paste the text formatting along with the text.</p>
		 */
		function get useRichTextClipboard():Boolean;
		
		/**
		 * <p>テキストフィールドのテキストを折り返すかどうかを示すブール値です。</p>
		 * <p>A Boolean value that indicates whether the text field has word wrap.</p>
		 */
		function get wordWrap():Boolean;
		function set wordWrap( value:Boolean ):void;
		
		
		
		
		
		/**
		 * <p>newText パラメータで指定されたストリングを、テキストフィールドのテキストの最後に付加します。</p>
		 * <p>Appends the string specified by the newText parameter to the end of the text of the text field.</p>
		 * 
		 * @param newText
		 * <p>既存のテキストに追加するストリングです。</p>
		 * <p>The string to append to the existing text.</p>
		 */
		function appendText( newText:String ):void;
		
		/**
		 * <p>文字の境界ボックスである矩形を返します。</p>
		 * <p>Returns a rectangle that is the bounding box of the character.</p>
		 * 
		 * @param charIndex
		 * <p>文字の 0 から始まるインデックス値です。つまり、最初の位置は 0、2 番目の位置は 1 で、以下同様に続きます。</p>
		 * <p>The zero-based index value for the character (for example, the first position is 0, the second position is 1, and so on). </p>
		 * @return
		 * <p>文字の境界ボックスを定義する x および y の最小値と最大値が指定された矩形です。 </p>
		 * <p>A rectangle with x and y minimum and maximum values defining the bounding box of the character.</p>
		 */
		function getCharBoundaries( charIndex:int ):Rectangle;
		
		/**
		 * <p>x および y パラメータで指定されたポイントにある文字の 0 から始まるインデックス値を返します。</p>
		 * <p>Returns the zero-based index value of the character at the point specified by the x and y parameters.</p>
		 * 
		 * @param x
		 * <p>文字の x 座標です。</p>
		 * <p>The x coordinate of the character.</p>
		 * @param y
		 * <p>文字の y 座標です。</p>
		 * <p>The y coordinate of the character.</p>
		 * @return
		 * <p>0 から始まる文字のインデックス値です。例えば、最初の位置は 0、次の位置は 1 と続きます（以下同様）。指定されたポイントがどの文字の上にもない場合は -1 を返します。</p>
		 * <p>The zero-based index value of the character (for example, the first position is 0, the second position is 1, and so on). Returns -1 if the point is not over any character.</p>
		 */
		function getCharIndexAtPoint( x:Number, y:Number ):int;
		
		/**
		 * <p>文字インデックスを指定すると、同じ段落内の最初の文字のインデックスを返します。</p>
		 * <p>Given a character index, returns the index of the first character in the same paragraph.</p>
		 * 
		 * @param charIndex
		 * <p>文字の 0 から始まるインデックス値です。つまり、最初の文字は 0、2 番目の文字は 1 で、以下同様に続きます。</p>
		 * <p>The zero-based index value of the character (for example, the first character is 0, the second character is 1, and so on).</p>
		 * @return
		 * <p>同じ段落内の最初の文字を示す、0 から始まるインデックス値です。</p>
		 * <p>The zero-based index value of the first character in the same paragraph.</p>
		 */
		function getFirstCharInParagraph( charIndex:int ):int;
		
		/**
		 * <p>&lt;img&gt; タグを使用して HTML フォーマットのテキストフィールドに追加されたイメージまたは SWF ファイルについて、指定された id の DisplayObject 参照を返します。</p>
		 * <p>Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an &lt;img&gt; tag.</p>
		 * 
		 * @param id
		 * <p>照合する id（id 属性（&lt;img&gt; タグ内））。</p>
		 * <p>The id to match (in the id attribute of the &lt;img&gt; tag).</p>
		 * @return
		 * <p>一致する id 属性をテキストフィールドの &lt;img&gt; タグ内に持つイメージまたは SWF ファイルに対応する表示オブジェクトです。外部ソースから読み込まれたメディアの場合、このオブジェクトは Loader オブジェクトであり、いったん読み込まれると、メディアオブジェクトはその Loader オブジェクトの子になります。SWF ファイルに埋め込まれたメディアの場合、これは読み込まれたオブジェクトです。&lt;img&gt; タグの中に一致する id が含まれない場合、このメソッドは null を返します。</p>
		 * <p>The display object corresponding to the image or SWF file with the matching id attribute in the &lt;img&gt; tag of the text field. For media loaded from an external source, this object is a Loader object, and, once loaded, the media object is a child of that Loader object. For media embedded in the SWF file, it is the loaded object. If no &lt;img&gt; tag with the matching id exists, the method returns null.</p>
		 */
		function getImageReference( id:String ):DisplayObject;
		
		/**
		 * <p>x および y パラメータで指定されたポイントにある行の 0 から始まるインデックス値を返します。</p>
		 * <p>Returns the zero-based index value of the line at the point specified by the x and y parameters.</p>
		 * 
		 * @param x
		 * <p>行の x 座標です。</p>
		 * <p>The x coordinate of the line.</p>
		 * @param y
		 * <p>行の y 座標です。</p>
		 * <p>The y coordinate of the line.</p>
		 * @return
		 * <p>0 から始まる行のインデックス値です。例えば、最初の行は 0、次の行は 1 と続きます（以下同様）。指定されたポイントがどの行の上にもない場合は -1 を返します。</p>
		 * <p>The zero-based index value of the line (for example, the first line is 0, the second line is 1, and so on). Returns -1 if the point is not over any line.</p>
		 */
		function getLineIndexAtPoint( x:Number, y:Number ):int;
		
		/**
		 * <p>charIndex パラメータで指定された文字を含む行の 0 から始まるインデックス値を返します。</p>
		 * <p>Returns the zero-based index value of the line containing the character specified by the charIndex parameter.</p>
		 * 
		 * @param charIndex
		 * <p>文字の 0 から始まるインデックス値です。つまり、最初の文字は 0、2 番目の文字は 1 で、以下同様に続きます。</p>
		 * <p>The zero-based index value of the character (for example, the first character is 0, the second character is 1, and so on).</p>
		 * @return
		 * <p>行の 0 から始まるインデックス値です。</p>
		 * <p>The zero-based index value of the line.</p>
		 */
		function getLineIndexOfChar( charIndex:int ):int;
		
		/**
		 * <p>特定のテキスト行内の文字数を返します。</p>
		 * <p>Returns the number of characters in a specific text line.</p>
		 * 
		 * @param lineIndex
		 * <p>長さが必要な行番号です。</p>
		 * <p>The line number for which you want the length.</p>
		 * @return
		 * <p>行内の文字数です。</p>
		 * <p>The number of characters in the line.</p>
		 */
		function getLineLength( lineIndex:int ):int;
		
		/**
		 * <p>指定されたテキスト行に関するメトリック情報を返します。</p>
		 * <p>Returns metrics information about a given text line.</p>
		 * 
		 * @param lineIndex
		 * <p>メトリック情報が必要な行番号です。</p>
		 * <p>The line number for which you want metrics information.</p>
		 * @return
		 * <p>TextLineMetrics オブジェクトです。</p>
		 * <p>A TextLineMetrics object.</p>
		 */
		function getLineMetrics( lineIndex:int ):TextLineMetrics;
		
		/**
		 * <p>lineIndex パラメータで指定された行の最初の文字の文字インデックスを返します。</p>
		 * <p>Returns the character index of the first character in the line that the lineIndex parameter specifies.</p>
		 * 
		 * @param lineIndex
		 * <p>0 から始まる行のインデックス値です。例えば、最初の行は 0、次の行は 1 と続きます（以下同様）。</p>
		 * <p>The zero-based index value of the line (for example, the first line is 0, the second line is 1, and so on).</p>
		 * @return
		 * <p>行の最初の文字を示す、0 から始まるインデックス値です。</p>
		 * <p>The zero-based index value of the first character in the line.</p>
		 */
		function getLineOffset( lineIndex:int ):int;
		
		/**
		 * <p>lineIndex パラメータで指定された行のテキストを返します。</p>
		 * <p>Returns the text of the line specified by the lineIndex parameter.</p>
		 * 
		 * @param lineIndex
		 * <p>The zero-based index value of the line (for example, the first line is 0, the second line is 1, and so on).</p>
		 * <p>0 から始まる行のインデックス値です。例えば、最初の行は 0、次の行は 1 と続きます（以下同様）。</p>
		 * @return
		 * <p>The text string contained in the specified line.</p>
		 * <p>指定された行に含まれるテキストストリングです。</p>
		 */
		function getLineText( lineIndex:int ):String;
		
		/**
		 * <p>文字インデックスを指定すると、指定された文字を含む段落の長さを返します。</p>
		 * <p>Given a character index, returns the length of the paragraph containing the given character.</p>
		 * 
		 * @param charIndex
		 * <p>文字の 0 から始まるインデックス値です。つまり、最初の文字は 0、2 番目の文字は 1 で、以下同様に続きます。</p>
		 * <p>The zero-based index value of the character (for example, the first character is 0, the second character is 1, and so on).</p>
		 * @return
		 * <p>段落内の文字数を返します。</p>
		 * <p>Returns the number of characters in the paragraph.</p>
		 */
		function getParagraphLength( charIndex:int ):int;
		
		/**
		 * <p>beginIndex パラメータと endIndex パラメータで指定された範囲のテキストのフォーマット情報を含む TextFormat オブジェクトを返します。</p>
		 * <p>Returns a TextFormat object that contains formatting information for the range of text that the beginIndex and endIndex parameters specify.</p>
		 * 
		 * @param beginIndex
		 * <p>オプション。テキストフィールド内のテキスト範囲の開始位置を指定する整数です。</p>
		 * <p>Optional; an integer that specifies the starting location of a range of text within the text field.</p>
		 * @param endIndex
		 * <p>オプション：該当するテキスト範囲の直後の文字の位置を指定する整数。意図したとおり、beginIndex と endIndex の値を指定すると、beginIndex から endIndex-1 までのテキストが読み込まれます。</p>
		 * <p>Optional; an integer that specifies the position of the first character after the desired text span. As designed, if you specify beginIndex and endIndex values, the text from beginIndex to endIndex-1 is read.</p>
		 * @return
		 * <p>指定されたテキストのフォーマットプロパティを表す TextFormat オブジェクトです。</p>
		 * <p>The TextFormat object that represents the formatting properties for the specified text.</p>
		 */
		function getTextFormat( beginIndex:int = -1, endIndex:int = -1 ):TextFormat;
		
		/**
		 * <p>現在の選択内容を value パラメータの内容に置き換えます。</p>
		 * <p>Replaces the current selection with the contents of the value parameter.</p>
		 * 
		 * @param value
		 * <p>現在選択されているテキストを置き換えるストリングです。</p>
		 * <p>The string to replace the currently selected text.</p>
		 */
		function replaceSelectedText( value:String ):void;
		
		/**
		 * <p>beginIndex パラメータと endIndex パラメータで指定された文字範囲を、newText パラメータの内容に置き換えます。</p>
		 * <p>Replaces the range of characters that the beginIndex and endIndex parameters specify with the contents of the newText parameter.</p>
		 * 
		 * @param beginIndex
		 * <p>置換範囲の開始位置の 0 から始まるインデックス値です。</p>
		 * <p>The zero-based index value for the start position of the replacement range.</p>
		 * @param endIndex
		 * <p>該当するテキスト範囲の直後の文字の 0 から始まるインデックス位置です。</p>
		 * <p>The zero-based index position of the first character after the desired text span.</p>
		 * @param newText
		 * <p>指定された文字範囲の置き換えに使用されるテキストです。</p>
		 * <p>The text to use to replace the specified range of characters.</p>
		 */
		function replaceText( beginIndex:int, endIndex:int, newText:String ):void;
		
		/**
		 * <p>最初の文字と最後の文字のインデックス値によって指定されたテキストを選択済みに設定します。最初の文字と最後の文字のインデックス値は、beginIndex パラメータおよび endIndex パラメータを使用して指定されます。</p>
		 * <p>Sets as selected the text designated by the index values of the first and last characters, which are specified with the beginIndex and endIndex parameters.</p>
		 * 
		 * @param beginIndex
		 * <p>選択範囲の先頭の文字の 0 から始まるインデックス値です。つまり、最初の文字が 0、2 番目の文字が 1 で、以下同様に続きます。</p>
		 * <p>The zero-based index value of the first character in the selection (for example, the first character is 0, the second character is 1, and so on).</p>
		 * @param endIndex
		 * <p>選択範囲の最後の文字を示す、0 から始まるインデックス値です。</p>
		 * <p>The zero-based index value of the last character in the selection.</p>
		 */
		function setSelection( beginIndex:int, endIndex:int ):void;
		
		/**
		 * <p>format パラメータで指定したテキストフォーマットを、テキストフィールド内の指定されたテキストに適用します。</p>
		 * <p>Applies the text formatting that the format parameter specifies to the specified text in a text field.</p>
		 * 
		 * @param format
		 * <p>文字と段落のフォーマット情報を含む TextFormat オブジェクトです。</p>
		 * <p>A TextFormat object that contains character and paragraph formatting information.</p>
		 * @param beginIndex
		 * <p>オプション：該当するテキスト範囲の直後の文字を指定して、ゼロから始まるインデックス位置を指定する整数。</p>
		 * <p>Optional; an integer that specifies the zero-based index position specifying the first character of the desired range of text.</p>
		 * @param endIndex
		 * <p>オプション：該当するテキスト範囲の直後の文字を指定する整数。意図したとおり、beginIndex と endIndex の値を指定すると、beginIndex から endIndex-1 までのテキストが更新されます。</p>
		 * <p>Optional; an integer that specifies the first character after the desired text span. As designed, if you specify beginIndex and endIndex values, the text from beginIndex to endIndex-1 is updated.</p>
		 */
		function setTextFormat( format:TextFormat, beginIndex:int = -1, endIndex:int = -1 ):void;
	}
}
