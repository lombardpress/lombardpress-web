<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html"/>
  
    <xsl:template match="/">
        
                <xsl:apply-templates/>
        

    </xsl:template>
    
    <xsl:template match="tei:teiHeader">

    </xsl:template>


    <xsl:template match="tei:head">
        <xsl:variable name="number" select="count(ancestor::tei:div)" />
        <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
        <xsl:variable name="fs"><xsl:value-of select="//tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>
        <xsl:element name="h{$number}"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute><xsl:element
                name="a"><xsl:attribute name="href">../text/textdisplay.php?fs=<xsl:value-of
                select="$fs"/>#<xsl:value-of
                select="$id"/></xsl:attribute>
            <xsl:apply-templates select="node()" /></xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div">
        <div id="{@xml:id}" class="plaoulparagraph"><xsl:apply-templates/></div>
    </xsl:template>


    <!--<xsl:template match="tei:p">
        <p id="{@xml:id}"><span class="paragraphnumber" style="padding-right: 15px; margin-left: 0px; font-weight: bold;"><xsl:number level="any" from="tei:text"/></span><xsl:apply-templates/></p>
    </xsl:template> -->
  <xsl:template match="tei:p">
    <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <xsl:variable name="pid"><xsl:value-of select="@xml:id"/></xsl:variable>
    
    <div class='para_wrap' id='pwrap_{@xml:id}' style="clear: both; float: none;">
      <p id="{@xml:id}" class="plaoulparagraph"><span id="pn{$pn}" class="paragraphnumber"><xsl:number level="any" from="tei:text"/></span><xsl:apply-templates/><span class="paragraphmenu"><a class="paragraphmenu"><span class="glyphicon glyphicon-menu-hamburger"/> Menu</a></span></p>
      <nav class="navbar navbar-default paradiv" id="menu_{@xml:id}" style="display: none;">
        <div class="navbar-header navbar-right">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#para-navbar-collapse-{$pid}">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="collapse navbar-collapse" id="para-navbar-collapse-{$pid}">
          <ul class="nav navbar-nav">
          <!-- <li class="active"><a href="/text">Text <span class="sr-only">(current)</span></a></li> -->
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Comments <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a class="js-show-para-comment">View Comments</a></li>
                <li><a href="js-post-para-comment">Post Comment</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">View Images <span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a class='js-show-para-image' data-msslug="reims">Reims</a></li>
                <li><a class='js-show-para-image' data-msslug="sorb">Sorbonne</a></li>
                <li><a class='js-show-para-image' data-msslug="svict">St. Victor</a></li>
                <li><a class='js-show-para-image' data-msslug="vat">Vatican</a></li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Paragraph Text Tools<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a class='js-show-xml'>Test1</a></li>
                <li><a class='js-show-text-comparison'>Test2</a></li>
                <li><a class='js-show-variants'>Test2</a></li>
              </ul>
            </li>

            
            
            <!-- <xsl:if test="$comments = 'true'">
              <li class="drop"><a>Comments</a>
                <div class="comments">
                  <a id="viewComments" onclick="comments('viewcomments.php', '{@xml:id}', '{$fs}', '{$pn}', '{$ln}', '{$ed}')">View Comments</a>
                  <a id="submitComment" onclick="comments('submitcomment.php', '{@xml:id}', '{$fs}', '{$pn}', '{$ln}', '{$ed}')">Submit Comment</a>
                </div>
              </li>
            </xsl:if> -->
            
            <!-- <xsl:if test="$images = 'true'">
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
            </xsl:if> -->
            
            <!-- <li class="drop"><a>Comparison Tools</a>
              <div class="compareTools">
                <div class="links">
                  <a class="viewVariants" data-fs="{$fs}" data-pid="{@xml:id}" data-ed="{$source_ed}">Variant List</a>
                  <a class="comparison showTags" data-fs="{$fs}" data-pid="{@xml:id}" data-ed="{$ed}" data-pn="{$pn}">Tags</a>
                  <a class="showXMLsource comparison" data-fs="{$fs}" data-pid="{@xml:id}" data-ms="{$msSource}" data-ed="{$source_ed}">XML TEI Mark-Up</a>
                  <a class="showParagraphStats comparison" data-fs="{$fs}" data-pid="{@xml:id}">Paragraph Statistics</a>
                  <a class="comparison" href="../textcomparisons/?fs={$fs}&amp;pid={@xml:id}&amp;sn={$ln}&amp;pn={$pn}&amp;ed={$source_ed}" target="_blank">Ms-Text Comparison</a> 
                  <xsl:if test="$images = 'true'">
                    <a class="comparison" href="../textcomparisons/?fs={$fs}&amp;pid={@xml:id}&amp;ed={$source_ed}" target="_blank">Ms-Text Comparison</a>
                  </xsl:if>
                  <a class="textdiff" href="../textdiff/textdiffdisplay.php?fs={$fs}&amp;pid={@xml:id}&amp;edbase={$source_ed}&amp;edcomp={$source_ed}&amp;msbase=edited&amp;mscomp=reims" target="_blank" data-fs="{$fs}" data-pid="{@xml:id}" data-msbase="edited" data-mscomp="reims" data-edbase="{$source_ed}" data-edcomp="{$source_ed}">Text-Diff Comparison</a>
                  
                </div>
                <div class="desc">
                  <p>Use these comparison tools to visualize the discrepancies between manuscript witnesses</p>
                </div>
              </div>
            </li> -->
            <!-- 
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
            -->
            <!--
            <li class="drop"><a>Citation/Sharing Tools</a>
              <div class="citationTools">
                <a class="how2cite" href="howtocite.php?sn={$ln}&amp;pn={$pn}&amp;enn={$ed}&amp;ern={$ern}">How to Cite</a>
              </div>
            </li>
            -->
          </ul>
        </div>
      </nav>
    </div>
    
    
  </xsl:template>
    
    <xsl:template match="tei:name">
        <span class="name"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="tei:title">
        <span class="title"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="tei:quote">
        <span class="quote"><xsl:text></xsl:text><xsl:apply-templates/><xsl:text></xsl:text></span>
    </xsl:template>
    
    <xsl:template match="tei:app">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:rdg">
        
    </xsl:template>
    
    <xsl:template match=" tei:note | tei:desc | tei:bibl | tei:pb | tei:cb">
        
    </xsl:template>
    
</xsl:stylesheet>
