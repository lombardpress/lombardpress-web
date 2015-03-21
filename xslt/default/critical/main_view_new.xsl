<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

<xsl:output method="html"/>
    
    <xsl:param name="englTransExists">false</xsl:param>
    <xsl:param name="latin">true</xsl:param>
    <xsl:param name="msSource">edited</xsl:param> <!-- param needed to tell paragraph menu which source code to show -->
    <xsl:param name="projectfilesbase">../../projectfiles/</xsl:param>
    <xsl:param name="projectdata">Conf/projectdata.xml</xsl:param>
    <xsl:param name="textlocaldirectory">GitTextfiles/</xsl:param>
    <xsl:param name="images">true</xsl:param>
    <xsl:param name="imagesmethod">none</xsl:param>
    <xsl:param name="comments">true</xsl:param>
    <!-- paramter that identifies where the crit apparatus is located -->
    <xsl:variable name="apploc"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:variantEncoding/@location"/></xsl:variable>
    <!-- paramter that identifies where the editoral notes are located; right not it is just using the app crit location-->
    <xsl:variable name="notesloc"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:variantEncoding/@location"/></xsl:variable>
    <xsl:variable name="variantdescription"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:variantEncoding/@method"/></xsl:variable>

    <xsl:variable name="ln"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/></xsl:variable>
    <xsl:variable name="fs"><xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div[1]/@xml:id"/></xsl:variable>
    <xsl:variable name="ed"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/@n"/></xsl:variable>
    <xsl:variable name="ern"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:editor"/></xsl:variable>
    <xsl:variable name='engTransDocName'>../translation_english/trans_engl_<xsl:value-of select="$fs"/>.xml</xsl:variable>
    <xsl:variable name="msSlugs" select="document(concat($projectfilesbase, $projectdata))/listofFileNames/div[@id='body']//div/item[fileName/@filestem=$fs]/hasParts/part"/>
    
    <xsl:param name="source_ed"><xsl:value-of select="$ed"/></xsl:param> <!-- local, head, version number: if not set just use version number from document -->
    
    <xsl:template match="/">
        <html>                        
            <body>            
                
                <xsl:call-template name="teiHeaderInfo"/>

                        <xsl:apply-templates/>

            <div class="footnotes">
                
                <xsl:choose>
                    <xsl:when test="$variantdescription = 'parallel-segmentation' and $notesloc = 'internal'">
                        <xsl:call-template name="footnotesBibl"/>
                    </xsl:when>
                    <xsl:when test="$notesloc = 'internal' or $notesloc = ''">
                        <xsl:call-template name="footnotesInternal"/>        
                    </xsl:when>
                    <xsl:when test="$notesloc = 'external'">
                        <xsl:call-template name="footnotesExternal"/>
                    </xsl:when>
                </xsl:choose>
            </div>
                
            <div class="variants">
                
                <xsl:choose>
                    <xsl:when test="$apploc = 'internal'">
                        <xsl:call-template name="variantsInternal"/>        
                    </xsl:when>
                    <xsl:when test="$apploc = 'external'">
                        <xsl:call-template name="variantsExternal"/>
                    </xsl:when>
                </xsl:choose>
                
                
                
            </div>    
            </body>
            
            
        </html>
        
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        
    </xsl:template>
    
    <xsl:include href="_paragraphtemplate.xsl"/>
    <!--<xsl:template xml:id="paragraphtemplate" match="tei:p">
        <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
        <xsl:variable name="pid"><xsl:value-of select="@xml:id"/></xsl:variable>
        
         <div class='para_wrap' id='pwrap_{@xml:id}' style="clear: both; float: none;">
        <p id="{@xml:id}" class="plaoulparagraph"><span id="pn{$pn}" class="paragraphnumber"><xsl:number level="any" from="tei:text"/></span><xsl:apply-templates/><span class="paragraphmenu"><a class="paragraphmenu">Paragraph Menu</a></span></p>
             <div class="paradiv" id="menu_{@xml:id}" style="display: none;">
                 <ul class="para_menu">
                 <xsl:if test="$comments = 'true'">
                     <li class="drop"><a>Comments</a>
                     <div class="comments">
                         <a id="viewComments" onclick="comments('viewcomments.php', '{@xml:id}', '{$fs}', '{$pn}', '{$ln}', '{$ed}')">View Comments</a>
                         <a id="submitComment" onclick="comments('submitcomment.php', '{@xml:id}', '{$fs}', '{$pn}', '{$ln}', '{$ed}')">Submit Comment</a>
                     </div>
                     </li>
                 </xsl:if>
                 
                 <xsl:if test="$images = 'true'">
                     <li class="drop"><a>View Mss. Images</a>
                     <div class="viewImages">
                         <div class="links">
                             <xsl:for-each select="$msSlugs">
                                 <xsl:variable name="partslug" select="./slug"/>
                                 <xsl:variable name="parttitle" select="./title"/>
                                 <a class="msimage showMsImage" data-method="{$imagesmethod}" data-pid="{$pid}" data-ms="{$partslug}" data-fs="{$fs}"><xsl:value-of
                                     select="$parttitle"/></a>
                             </xsl:for-each>
                            <a class="showFoliation" data-pid="{$pid}" data-ed="{$source_ed}" data-fs="{$fs}">Image Foliation</a>
                             </div>
                                 <div class="desc">
                                     <p>Click on any of the links to the left to view the manuscript image for this paragraph</p>
                                     <p>Select "Image Foliation" to access links to the full folio image where the paragraph occurs</p>
                                 </div>
                     </div>
                     </li>
                 </xsl:if>
                 
                     <li class="drop"><a>Comparison Tools</a>
                     <div class="compareTools">
                         <div class="links">
                         <a class="viewVariants" data-fs="{$fs}" data-pid="{@xml:id}" data-ed="{$source_ed}">Variant List</a>
                         <a class="comparison showTags" data-fs="{$fs}" data-pid="{@xml:id}" data-ed="{$ed}" data-pn="{$pn}">Tags</a>
                         <a class="showXMLsource comparison" data-fs="{$fs}" data-pid="{@xml:id}" data-ms="{$msSource}" data-ed="{$source_ed}">XML TEI Mark-Up</a>
                         <a class="showParagraphStats comparison" data-fs="{$fs}" data-pid="{@xml:id}">Paragraph Statistics</a>
                         <!-\-<a class="comparison" href="../textcomparisons/?fs={$fs}&amp;pid={@xml:id}&amp;sn={$ln}&amp;pn={$pn}&amp;ed={$source_ed}" target="_blank">Ms-Text Comparison</a>-\->
                             <xsl:if test="$images = 'true'">
                             <a class="comparison" href="../textcomparisons/?fs={$fs}&amp;pid={@xml:id}&amp;ed={$source_ed}" target="_blank">Ms-Text Comparison</a>
                             </xsl:if>
                         <a class="textdiff" href="../textdiff/textdiffdisplay.php?fs={$fs}&amp;pid={@xml:id}&amp;edbase={$source_ed}&amp;edcomp={$source_ed}&amp;msbase=edited&amp;mscomp=reims" target="_blank" data-fs="{$fs}" data-pid="{@xml:id}" data-msbase="edited" data-mscomp="reims" data-edbase="{$source_ed}" data-edcomp="{$source_ed}">Text-Diff Comparison</a>
                         <!-\- move to nav bar <a class="comparison" href="../juxta_comparison/?fs={$fs}&amp;pid={@xml:id}&amp;sn={$ln}&amp;pn={$pn}&amp;ed={$source_ed}" target="_blank">juxta text comparison</a> -\-> 
                         </div>
                         <div class="desc">
                             <p>Use these comparison tools to visualize the discrepancies between manuscript witnesses</p>
                         </div>
                     </div>
                     </li>
                 
                 
                 <xsl:if test="$englTransExists = 'true' and $latin = 'true'">
                 
                    <li class="drop"><a>Translation</a>
                     <div class="translation">
                         <a class="showParagraph" data-pid="{@xml:id}" data-ms="engl" data-fs="{$fs}" data-xsltdoc="paragraph_display">View Translation in Window </a>
                         <a href="textdisplay.php?flag={$fs}&amp;trans=english#{@xml:id}">Switch To English Text</a>
                     </div>
                    </li>
                 
                 </xsl:if>
                     <xsl:if test="$englTransExists = 'true' and $latin = 'false'">

                    <li class="drop"><a>Latin Text</a>
                     <div class="translation">
                         <a class="showParagraph" data-pid="{@xml:id}" data-ms="edited" data-fs="{$fs}" data-xsltdoc="paragraph_display">View Latin in Window</a>
                         <a href="textdisplay.php?flag={$fs}#{@xml:id}">Switch To Latin Text</a>
                     </div>
                    </li>

                 </xsl:if>
                 
                     <li class="drop"><a>Citation/Sharing Tools</a>
                         <div class="citationTools">
                             <a class="how2cite" href="howtocite.php?sn={$ln}&amp;pn={$pn}&amp;enn={$ed}&amp;ern={$ern}">How to Cite</a>
                           <!-\- <a href="mailto:?subject={$ln} paragraph {$pn}&amp;body=Check out this site http://petrusplaoul.org/text/textdisplay.php?flag={$fs}#{@xml:id}" title="Share by Email">Share by Email</a> -\->
                             <!-\-<a href="https://twitter.com/share" class="twitter-share-button" data-url="http://jeffreycwitt.com/plaoul/text/textdisplay.php?flag={$fs}#{@xml:id}" data-text="Check out paragraph {$pn} from {$ln} of Peter Plaoul's Commentary on the Sentences" data-via="jeffreycwitt" data-count="none">Share via Twitter</a>-\->
                             <!-\-<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>-\->
                         </div>
                     </li>
                 </ul>

             </div>
        </div>


    </xsl:template>-->



    <xsl:attribute-set name="hid">
        <xsl:attribute name="id"><xsl:value-of select="tei:head/@xml:id"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template match="tei:head">
        <xsl:variable name="id" select="count(ancestor::tei:div)" />
        <xsl:element name="h{$id}">
            <xsl:attribute name="id"><xsl:apply-templates select="@*"/></xsl:attribute>
            <xsl:attribute name="class">divisionHeader divisionHeaderHide</xsl:attribute>
            <xsl:apply-templates select="node()" />
        </xsl:element>
    </xsl:template>
    
    
    
    <xsl:template match="tei:head[@subtype='title']">
        <!-- this is currently left here because the css counter numbering system messes up if this h1 is not present -->
<h1 id="{@xml:id}" class="sectionTitle" style="visibility: hidden; font-size: 2px; padding: 0; margin: 0; height: 0px"><xsl:apply-templates/></h1>
    </xsl:template>
    
    <xsl:template match="tei:cb">
        <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
        <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
        <xsl:variable name="fullcn"><xsl:value-of select="@n"/></xsl:variable>
        
        <xsl:variable name="length"><xsl:value-of select="string-length($fullcn)-2"/></xsl:variable>
        <xsl:variable name="folionumber"><xsl:value-of select="substring($fullcn,1, $length)"/></xsl:variable>
        <xsl:variable name="side_column"><xsl:value-of select="substring($fullcn, $length+1)"/></xsl:variable>
        <xsl:variable name="just_column"><xsl:value-of select="substring($fullcn, $length+2, 1)"/></xsl:variable>
        <xsl:variable name="justSide"><xsl:value-of select="substring($fullcn, $length+1, 1)"/></xsl:variable>
        <xsl:variable name="pictureName"><xsl:value-of select="$ms"/><xsl:value-of select="$folionumber"/><xsl:value-of select="$justSide"/>.jpg</xsl:variable>

        <xsl:element name="a">
            <xsl:if test="$images = 'true'">
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="$ms = 'R'">../textcolumnview/?ms=reims&amp;f=<xsl:value-of select="$folionumber"/>&amp;s=<xsl:value-of
                            select="$justSide"/>&amp;c=<xsl:value-of select="$just_column"/>
                    </xsl:when>
                    <xsl:when test="$ms = 'V'">
../textcolumnview/?ms=vat&amp;f=<xsl:value-of select="$folionumber"/>&amp;s=<xsl:value-of
                            select="$justSide"/>&amp;c=<xsl:value-of select="$just_column"/>
                    </xsl:when>
                    <xsl:when test="$ms = 'SV'">
                        ../textcolumnview/?ms=svict&amp;f=<xsl:value-of select="$folionumber"/>&amp;s=<xsl:value-of
                            select="$justSide"/>&amp;c=<xsl:value-of select="$just_column"/>

                    </xsl:when>
                    <xsl:when test="$ms = 'S'">
                        ../textcolumnview/?ms=sorb&amp;f=<xsl:value-of select="$folionumber"/>&amp;s=<xsl:value-of
                            select="$justSide"/>&amp;c=<xsl:value-of select="$just_column"/>

                    </xsl:when>

                </xsl:choose>
            </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="class">folnum</xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="$ms"/><xsl:text></xsl:text><xsl:value-of select="$folionumber"/><xsl:value-of select="$side_column"/>
        </xsl:element>

    </xsl:template>

    <xsl:template match="tei:pb">
        <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
        <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
        <xsl:variable name="fullcn"><xsl:value-of select="@n"/></xsl:variable>
        
        <!-- this variable gets length of Ms abbrev and folio number after substracting side -->
        <xsl:variable name="length"><xsl:value-of select="string-length($fullcn)-1"/></xsl:variable>
        <!-- this variable separates isolates folio number by skipping msAbbrev and then not including side designation -->
        <xsl:variable name="folionumber"><xsl:value-of select="substring($fullcn,1, $length)"/></xsl:variable>
        <!-- this desgination gets side by skipping lenghth of msAbbrev and folio number and then getting the first character that occurs -->
        <xsl:variable name="justSide"><xsl:value-of select="substring($fullcn, $length+1, 1)"/></xsl:variable>
        <xsl:variable name="pictureName"><xsl:value-of select="$ms"/><xsl:value-of select="$folionumber"/><xsl:value-of select="$justSide"/>.jpg</xsl:variable>

        <!-- note like in CB above this is condition is a problem because it relies on hardcoded Slug names -->
        <xsl:element name="a">
            <xsl:if test="$images = 'true'">
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="$ms = 'L'">../textcolumnview/?ms=lon&amp;f=<xsl:value-of select="$folionumber"/>&amp;s=<xsl:value-of
                            select="$justSide"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="class">folnum</xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="$ms"/><xsl:text> </xsl:text><xsl:value-of select="$folionumber"/><xsl:value-of select="$justSide"/>
        </xsl:element>

    </xsl:template>

    <xsl:template match="tei:div">
        <div id="{@xml:id}" class="plaouldiv"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        
        [<xsl:apply-templates></xsl:apply-templates>]
    </xsl:template>

    <xsl:include href="_notestemplate.xsl"/>
    <!-- <xsl:template match="tei:note">
        <xsl:variable name="id"><xsl:number count="//tei:note" level="any" format="a"/></xsl:variable>
        <sup><a href="#footnote{$id}" name="footnotereference{$id}" class="footnote"><xsl:copy-of select="$id"/></a></sup>
    </xsl:template> -->

    <xsl:include href="_apptemplate.xsl"/>
    <!-- <xsl:template match="tei:app">
        <xsl:variable name="id"><xsl:number count="//tei:app" level="any" format="1"/></xsl:variable>
        <sup><a href="#variant{$id}" name="variantreference{$id}" class="appnote"><xsl:copy-of select="$id"/></a></sup>
    </xsl:template>-->
    
    <xsl:template match="tei:anchor">
        <xsl:variable name="id"><xsl:number count="//tei:anchor" level="any" format="1"/></xsl:variable>
        <sup><a href="#variant{$id}" name="variantreference{$id}" class="appnote"><xsl:copy-of select="$id"/></a></sup>
    </xsl:template> 
    
    <xsl:template match="tei:hi[@rend='italic']" name="italic">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <xsl:variable name="ref"><xsl:value-of select="./@ref"/></xsl:variable>
        <xsl:variable name="refID"><xsl:value-of select="substring-after($ref, '#')"/></xsl:variable>
        <xsl:variable name="documentPath" select="concat($projectfilesbase, 'citationlists/workscited.xml')"/>
        <xsl:variable name="type"><xsl:value-of select="document($documentPath)/tei:TEI/tei:text/tei:body/tei:listBibl/tei:listBibl[tei:bibl[@xml:id=$refID]]/@type"/></xsl:variable>
        <xsl:variable name="author"><xsl:value-of select="document($documentPath)/tei:TEI/tei:text/tei:body/tei:listBibl/tei:listBibl/tei:bibl[@xml:id=$refID]/tei:author/@ref"/></xsl:variable>
        <xsl:variable name="authorID"><xsl:value-of select="substring-after($author, '#')"/></xsl:variable>
        <span class="title" data-type="{$type}" data-title="{$refID}" data-author="{$authorID}"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:name">
        <xsl:variable name="ref"><xsl:value-of select="./@ref"/></xsl:variable>
        <xsl:variable name="refID"><xsl:value-of select="substring-after($ref, '#')"/></xsl:variable>
        <xsl:variable name="documentPath" select="concat($projectfilesbase, 'citationlists/Prosopography.xml')"/>
        <xsl:variable name="type"><xsl:value-of select="document($documentPath)/tei:TEI/tei:text/tei:body/tei:listPerson/tei:listPerson[tei:person[@xml:id=$refID]]/@type"/></xsl:variable>
        <span class="name" data-type="{$type}" data-name="{$refID}"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:seg">
        <xsl:variable name="ana"><xsl:value-of select="./@ana"/></xsl:variable>
        <xsl:variable name="anaID"><xsl:value-of select="translate($ana, '#', '')"/></xsl:variable>
        <xsl:variable name="documentPath" select="concat($projectfilesbase, 'citationlists/subjectlist.xml')"/>
        <xsl:variable name="type" select="document($documentPath)//tei:category[@xml:id=$anaID]/ancestor::tei:category/@xml:id"/>
        <xsl:choose>
            <xsl:when test="count($type) > 0">
        <span class="subject" data-type="{$type}" data-subjectID="{$anaID}"><xsl:apply-templates/></span>
        </xsl:when>
        <xsl:otherwise>
            <span class="subject" data-type="{$anaID}" data-subjectID="{$anaID}"><xsl:apply-templates/></span>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="tei:quote">
        <xsl:variable name="quoterefid" select="translate(./@ana, '#', '')"/>
                <span class="quote" id="{@xml:id}" data-quoterefid="{$quoterefid}">"<xsl:apply-templates/>"</span>
    </xsl:template>
    
    <xsl:template match="tei:unclear">
        <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
        <span style="background-color: #F3F3F3;" class="unclear" data-text="{$text}"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='bold']">
        <em style="font-weight: bold; text-decoration: none;"><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    
        <xsl:template name="teiHeaderInfo">

            <div class="maintitle">
                <h1 id="title"><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                <p>Edited by <xsl:value-of select="//tei:titleStmt/tei:editor"/></p>
                <xsl:if test="//tei:titleStmt/tei:editor[@role='PeerReviewEditor']">
                    <xsl:variable name="preditor"><xsl:value-of select="//tei:titleStmt/tei:editor[@role='PeerReviewEditor']"/></xsl:variable>
                    <p>Peer Reviewed by: <a href="../preditors/preditorslist.php?preditor={$preditor}" target="blank"><span id="prEditorName"><xsl:value-of select="$preditor"/></span></a></p>
                </xsl:if>
                <xsl:if test="//tei:titleStmt/tei:editor[@role='AssistantEditor']">
                    <xsl:variable name="assistantEditor"><xsl:value-of select="//tei:titleStmt/tei:editor[@role='AssistantEditor']"/></xsl:variable>
                    <p>Assisted by: <span id="assistantEditorName"><xsl:value-of select="$assistantEditor"/></span></p>
                </xsl:if>
            </div>

            <div id="publicationInfo">
                <div id="pubShowLink">
                <p><a id="viewFullPubInfo">View full publication statement</a></p>
            </div>

            <div id="pubInfo">
            <p>Title: <span id="sectionTitle" class="sectionTitle"><xsl:value-of select="//tei:titleStmt/tei:title"/></span></p>
            <p>By: <xsl:value-of select="//tei:titleStmt/tei:author"/></p>
            <p>Edited by: <span id="editorName"><xsl:value-of select="//tei:titleStmt/tei:editor"/></span></p>
            <xsl:if test="//tei:titleStmt/tei:editor[@role='PeerReviewEditor']">
                <xsl:variable name="preditor"><xsl:value-of select="//tei:titleStmt/tei:editor[@role='PeerReviewEditor']"/></xsl:variable>
                <p>Peer Reviewed by: <a href="../preditors/preditorslist.php?preditor={$preditor}" target="blank"><span id="prEditorName"><xsl:value-of select="$preditor"/></span></a></p>
                    </xsl:if>
            <xsl:if test="//tei:titleStmt/tei:editor[@role='AssistantEditor']">
                    <xsl:variable name="assistantEditor"><xsl:value-of select="//tei:titleStmt/tei:editor[@role='AssistantEditor']"/></xsl:variable>
                <xsl:variable name="assistantEditorID"><xsl:value-of select="//tei:titleStmt/tei:editor[@role='AssistantEditor']/@xml:id"/></xsl:variable>
                <xsl:variable name="assistantEditorRefID"><xsl:value-of select="concat('#', $assistantEditorID)"/></xsl:variable>
                    <p>Assisted by: <span id="assistantEditorName"><xsl:value-of select="$assistantEditor"/></span>
                <xsl:if test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[tei:name[@ref=$assistantEditorRefID]]">
                    <span class="respStmt"> | <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[tei:name/@ref=$assistantEditorRefID]/tei:resp"/></span>
                </xsl:if>
                    </p>
            </xsl:if>
            <p><a href="../versionlog/?fs={$fs}&amp;target=v_{$ed}">Edition: <span id="editionNumber"><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/@n"/></span> | <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/tei:date"/></a></p>
            <p>Original Publication: <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>, <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/>, <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/></p>
            <p>License Availablity: <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/@status"/>, <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/> </p>
            <p style="display: none;"><span id="filestem"><xsl:value-of select="//tei:body/tei:div/@xml:id"/></span></p>
            </div>
        </div>
        </xsl:template>

<!-- this template deals with cross references; it is triggerd by any <ref> element that contains type="crossReference". 
        Normally, all of these types should be found with editorial notes. These notes can be in an internal document or an external document. 
        This should be specified in the TeiHeader. If nothing is declared, the script will assume that the location of the note is internal -->
    
    <xsl:template match="tei:ref[@type='crossReference']">
        <xsl:choose>
            <xsl:when test="starts-with(normalize-space(@target), '#')">
               <a href="{@target}"><xsl:apply-templates/></a>
            </xsl:when>
        <xsl:when test="starts-with(normalize-space(@target), 'http')">
            <a href="{@target}"><xsl:apply-templates/></a>
        </xsl:when>
        <xsl:otherwise>
                 <xsl:variable name="uriTarget"><xsl:value-of select="@target"/></xsl:variable>
                <xsl:variable name="filename" select="substring-before($uriTarget, '#')"/>
                <xsl:variable name="filestem" select="substring-before($filename, '.')"/>
                <xsl:variable name="FULLfilename" select="concat($projectfilesbase, $textlocaldirectory, $filestem, '/', $filename)"/>
                <xsl:variable name="refPid" select="substring-after($uriTarget, '#')"/>
                <xsl:variable name="dispFlag" select="concat('textdisplay.php?flag=', $filestem, '#', $refPid)"/>
                <xsl:element name="a"><xsl:attribute name="href"><xsl:value-of select="$dispFlag"/></xsl:attribute><xsl:apply-templates/><xsl:text> </xsl:text><span id="crRef_{$refPid}" class="crRef_pn" data-pid="{$refPid}" data-fs="{$filestem}" data-ed="{$source_ed}"></span></xsl:element> <xsl:text> </xsl:text>
                <xsl:element name="a">
                <xsl:attribute name="class">crRefInlineLinkFromFnote</xsl:attribute>
                <xsl:attribute name="id">inlineCrRefTrigger_<xsl:value-of select="$refPid"/></xsl:attribute>
                <!-- this was the old way using onClick which has been accomplished through jquery .click bind  <xsl:attribute name="onClick">displayCrRef('<xsl:value-of select="$refPid"/>', '<xsl:value-of select="$filestem"/>', '<xsl:value-of select="$pidOfReferringP"/>')</xsl:attribute>-->
                <xsl:attribute name="data-pid"><xsl:value-of select="$refPid"/></xsl:attribute>
                <xsl:attribute name="data-refFS"><xsl:value-of select="$filestem"/></xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="$notesloc = 'internal' or $notesloc = ''"> <!-- if no location is set we assume the location is internal -->
                        <xsl:variable name="pidOfReferringP" select="ancestor::tei:p/@xml:id"></xsl:variable>
                        <xsl:attribute name="data-pidOfReferringP"><xsl:value-of select="$pidOfReferringP"/></xsl:attribute>
                    </xsl:when>
                    <xsl:when test="$notesloc = 'external'"> <!-- this is conditional is required for adjustments in infomration retrieval when the notes list is in an external file -->
                        <xsl:variable name="pidOfReferringP" select="translate(ancestor::tei:div/@corresp, '#', '')"/>
                        <xsl:attribute name="data-pidOfReferringP"><xsl:value-of select="$pidOfReferringP"/></xsl:attribute>
                    </xsl:when>
                    </xsl:choose>
                
                <xsl:attribute name="data-ed"><xsl:value-of select="$source_ed"/></xsl:attribute>
                Click to view referenced text in-line</xsl:element>
            
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
<!-- End of Cross Referece Template -->
    
    <xsl:template match="tei:reg">
        <span class="reg" style="display: none;"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template name="footnotesInternal">
        <ul><xsl:for-each select="//tei:note">
            <xsl:variable name="id"><xsl:number count="//tei:note" level="any" format="a"/></xsl:variable>
            <li id="footnote{$id}"><a href="#footnotereference{$id}"><xsl:copy-of select="$id"/></a> -- <xsl:apply-templates/></li>
            
        </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template name="footnotesExternal">
        
        <ul><xsl:for-each select="document(concat($projectfilesbase, $textlocaldirectory, $fs, '/notes_', $fs, '.xml'))//tei:note">
            <xsl:variable name="id"><xsl:number count="//tei:note" level="any" format="a"/></xsl:variable>
            <li id="footnote{$id}"><a href="#footnotereference{$id}"><xsl:copy-of select="$id"/></a> -- <xsl:apply-templates/></li>
            
        </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template name="footnotesBibl">
            <ul><xsl:for-each select="//tei:bibl">
                <xsl:variable name="id"><xsl:number count="//tei:bibl" level="any" format="a"/></xsl:variable>
                <li id="footnote{$id}"><a href="#footnotereference{$id}"><xsl:copy-of select="$id"/></a> -- <xsl:apply-templates/></li>

            </xsl:for-each>
            </ul>
        </xsl:template>

   
    
    <xsl:template name="variantsInternal">
       
        <ul class="variantlist">
            
            <xsl:for-each select="//tei:app">

                <xsl:variable name="id">
                    <xsl:number count="//tei:app" level="any" format="1"/>
                </xsl:variable>
                
                <li id="variant{$id}"><a href="#variantreference{$id}"><xsl:copy-of select="$id"/></a><xsl:text> </xsl:text>
                    <xsl:value-of select="tei:lem"/>]                         
                         <xsl:for-each select="tei:rdg">
                             <xsl:choose>
                            <xsl:when test="contains(@type, 'om.')">
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <em><xsl:value-of select="@type"/></em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>

                            </xsl:when>
                             <xsl:when test="contains(@type, 'add.')">
                                 <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <em><xsl:value-of select="@type"/></em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'add.sed.del.')">
                                <xsl:value-of select="tei:del/tei:add"/><xsl:text> </xsl:text>
                                <em><xsl:value-of select="@type"/></em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'corr.')">
                                <xsl:value-of select="tei:subst/tei:add"/><xsl:text> </xsl:text>
                                <em>corr. ex</em><xsl:text> </xsl:text>
                                <xsl:value-of select="tei:subst/tei:del"/><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>    
                            <xsl:otherwise>
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:otherwise>
                            </xsl:choose>
                         </xsl:for-each>
                  </li>  
</xsl:for-each>
            
        </ul>
        
    </xsl:template>

    <xsl:template name="variantsExternal">
        
        <ul class="variantlist">
            <xsl:for-each select="document(concat($projectfilesbase, $textlocaldirectory, $fs, '/app_', $fs, '.xml'))//tei:app">
                
                <xsl:variable name="id">
                    <xsl:number count="//tei:app" level="any" format="1"/>
                </xsl:variable>
                
                <li id="variant{$id}"><a href="#variantreference{$id}"><xsl:copy-of select="$id"/></a><xsl:text> </xsl:text>
                    <xsl:value-of select="tei:lem"/>]                         
                    <xsl:for-each select="tei:rdg">
                        <xsl:choose>
                            <xsl:when test="contains(@type, 'om.')">
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <em>om.</em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'addCorrection') or ./@type='corrAddition'"> <!-- eventually the "contains" options should be removed as "corrDeletion, corrAddition" becomes the standard in the app schema -->
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <em>add.</em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'add.sed.del.') or ./@type='corrDeletion'">
                                <xsl:value-of select="tei:corr/tei:del"/><xsl:text> </xsl:text>
                                <em>add. sed del.</em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'corr.') or ./@type='corrReplace'">
                                <xsl:value-of select="tei:corr/tei:add"/><xsl:text> </xsl:text>
                                <em>corr. ex</em><xsl:text> </xsl:text>
                                <xsl:value-of select="tei:corr/tei:del"/><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'rep.')">
                                <xsl:text> </xsl:text>
                                <em>rep.</em>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text> </xsl:text>
                            </xsl:when>
                            <xsl:when test="contains(@type, 'intextu')">
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <em>add. in textu</em><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text> </xsl:text>
                            </xsl:when>
                            
                            
                            
                            <xsl:otherwise>
                                <xsl:value-of select="."/><xsl:text> </xsl:text>
                                <xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </li>  
            </xsl:for-each>
            
        </ul>
        
    </xsl:template>
</xsl:stylesheet>