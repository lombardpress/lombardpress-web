<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html"/>
    <xsl:param name="default-ms-image">reims</xsl:param>
    <xsl:variable name="itemid"><xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>
  
    <xsl:template match="/">
        
                <xsl:apply-templates/>
        

    </xsl:template>
    
    <xsl:template match="tei:teiHeader">

    </xsl:template>


    <xsl:template match="tei:head">
        <xsl:variable name="number" select="count(ancestor::tei:div)" />
        <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
        <xsl:element name="h{$number}"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        <xsl:apply-templates/>
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
            <li><a class="js-show-comments-window">Comments</a></li>
            <li><a class="js-show-para-image-window" data-itemid="{$itemid}" data-pid="{@xml:id}" data-msslug="{$default-ms-image}">Ms Images</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Paragraph Text Tools<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a class='js-show-xml'>Test1</a></li>
                <li><a class='js-show-text-comparison'>Test2</a></li>
                <li><a class='js-show-variants'>Test2</a></li>
              </ul>
            </li>
            <li><a>How To Cite</a></li>
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
