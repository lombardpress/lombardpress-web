<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
  
  <xsl:output method="html" indent="yes"/>
  <xsl:param name="pid">l1-cpspfs</xsl:param>  
  
  <xsl:template match="/">
    <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <h3 class="lbp-side-bar-paragraph-heading"><a class="js-side-bar-scroll-to-paragraph" data-pid="{$pid}">Variants for paragraph <xsl:value-of select="count(//tei:body//tei:p) - count(//tei:p[@xml:id=$pid]//following::tei:p)"/></a></h3>
    <ul id="{$pid}-variant-list" class="lbp-paragraph-variant-list">
    <xsl:variable name="test" select="$pid"/>  
      <xsl:apply-templates select="//tei:*[@xml:id=$pid]//tei:app"/>
    </ul>
  </xsl:template>
  
  <xsl:template match="tei:app">
    <xsl:variable name="appnum" select="count(preceding::tei:app) + 1"></xsl:variable>
    <li class="lbp-side-window-variant" data-lem-ref="lbp-app-lem-{$appnum}">
      <xsl:value-of select="$appnum"/><xsl:text> </xsl:text>
      <xsl:value-of select="tei:lem"/>]
    	<xsl:for-each select="tei:rdg">
    		<xsl:choose>
    			<xsl:when test="./@type='variation-absent'">
    				<xsl:value-of select="."/><xsl:text> </xsl:text>
    				<em>om.</em><xsl:text> </xsl:text>
    				<xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
    			</xsl:when>
    			<xsl:when test="./@type='variation-present'">
    				<xsl:choose>
    					<xsl:when test="./@cause='repetition'">
    						<xsl:text> </xsl:text>
    						<em>iter</em>
    						<xsl:value-of select="translate(@wit, '#', '')"/><xsl:text> </xsl:text>
    					</xsl:when>
    					<xsl:otherwise>
    						<xsl:text> </xsl:text>
    						<xsl:value-of select="."/><xsl:text> </xsl:text>
    						<em>in textu</em><xsl:text> </xsl:text>
    						<xsl:value-of select="translate(@wit, '#', '')"/><xsl:text> </xsl:text>
    					</xsl:otherwise>
    				</xsl:choose>
    			</xsl:when>
    			
    			<xsl:when test="./@type='correction-addition'"> 
    				<xsl:value-of select="tei:add"/><xsl:text> </xsl:text>
    				<em>add.</em><xsl:text> </xsl:text>
    				<xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
    			</xsl:when>
    			
    			<xsl:when test="./@type='correction-deletion'">
    				<xsl:value-of select="tei:del"/><xsl:text> </xsl:text>
    				<em>add. sed del.</em><xsl:text> </xsl:text>
    				<xsl:value-of select="translate(@wit, '#', '')"/><xsl:text>   </xsl:text>
    			</xsl:when>
    			<xsl:when test="./@type='correction-substitution'">
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
      <xsl:if test="./tei:note">
        <ul>
        <xsl:for-each select="./tei:note">
          <xsl:call-template name="app-notes"/>
        </xsl:for-each>
        </ul>
      </xsl:if>
    </li>    
    
  </xsl:template>
  <xsl:template match="tei:note" name="app-notes">
    <li><xsl:apply-templates/></li>
  </xsl:template>
  
</xsl:stylesheet>
