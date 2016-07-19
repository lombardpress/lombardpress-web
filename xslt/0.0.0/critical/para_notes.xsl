<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
  
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="pid">l1-cpspfs</xsl:param>  
  
  <xsl:template match="/">
    <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <h3 class="lbp-side-bar-paragraph-heading"><a class="js-side-bar-scroll-to-paragraph" data-pid="{$pid}">Notes for paragraph <xsl:value-of select="count(//tei:body//tei:p) - count(//tei:p[@xml:id=$pid]//following::tei:p)"/></a></h3>
    <ul id="{$pid}-notes-list" class="lbp-paragraph-notes-list">
      <xsl:apply-templates select="//tei:*[@xml:id=$pid]//tei:bibl"/>
    </ul>
  </xsl:template>
  
  <xsl:template match="tei:bibl">
    
      <xsl:variable name="notenum"><xsl:number count="tei:bibl" level="any" format="a" from="tei:text"/></xsl:variable>
      <xsl:choose>
        <xsl:when test="./preceding-sibling::tei:quote">
          <xsl:variable name="quote-ref-id" select="./preceding-sibling::tei:quote/@xml:id"></xsl:variable>
          <li class="lbp-side-window-note" data-note="{$quote-ref-id}">
            <xsl:value-of select="$notenum"/><xsl:text> </xsl:text>
            <xsl:apply-templates/>
          </li>
        </xsl:when>
      	<xsl:when test="./preceding-sibling::tei:ref">
      		<xsl:variable name="quote-ref-id" select="./preceding-sibling::tei:ref/@xml:id"></xsl:variable>
      		<li class="lbp-side-window-note" data-note="{$quote-ref-id}">
      			<xsl:value-of select="$notenum"/><xsl:text> </xsl:text>
      			<xsl:apply-templates/>
      		</li>
      	</xsl:when>
        <xsl:otherwise>
          <xsl:variable name="quote-ref-id" select="./parent::ref/@xml:id"></xsl:variable>
          <li class="lbp-side-window-note" data-note="lbp-note-{$quote-ref-id}">
            <xsl:value-of select="$notenum"/><xsl:text> </xsl:text>
            <xsl:apply-templates/>
          </li>
        </xsl:otherwise>
      </xsl:choose> 
      
    
  </xsl:template>
  
  <xsl:template match="tei:title">
    <span class="title"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="tei:name">
    <span class="name"><xsl:apply-templates/></span>
  </xsl:template>
  
  
</xsl:stylesheet>
