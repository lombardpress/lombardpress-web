<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
    
    <xsl:output method="text" omit-xml-declaration="yes"/>
    <xsl:param name="ms">edited</xsl:param>
    
    <xsl:template match="/" mode="text">
        <xsl:apply-templates mode="text"/>
    </xsl:template>
    
    <xsl:template match="*" mode="text">
        <xsl:apply-templates mode="text"/>
        <xsl:text>
</xsl:text>
    </xsl:template>
    
    <!-- elements to be processed with hard return -->
    
    <xsl:template match="tei:head | tei:p" >
        <xsl:apply-templates></xsl:apply-templates>
        <xsl:text>
            
         </xsl:text>
    </xsl:template>
    <xsl:template match="tei:lb">
      <!--  <xsl:choose>
        <xsl:when test="./@ed=$ms">
        <xsl:text> 
        </xsl:text> 
        </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose> -->
        
    </xsl:template>
    
    <!-- elements that SHOULD NOT be processed with a hard return -->
    <xsl:template match="tei:quote | tei:name | tei:title | tei:hi | tei:place">
        <xsl:text> </xsl:text>
        <xsl:apply-templates></xsl:apply-templates>
        
    </xsl:template>
    <!-- elements that should not be processed at all -->
    
    <xsl:template match="tei:teiHeader | tei:index | tei:hi/tei:desc | tei:facsimile | tei:g | tei:reg | tei:rdg | tei:note | tei:bibl"/>
    
     <!--removes any extraneous indentation and soft returns--> 
    <!--<xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
        
    </xsl:template>-->
</xsl:stylesheet>