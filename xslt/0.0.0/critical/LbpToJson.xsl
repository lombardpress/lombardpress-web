<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">
    <xsl:variable name="totalparas" select="count(//tei:body//tei:p)"/>
    <xsl:output method="text" encoding="UTF-8" media-type="text/plain"/>
    <!--<xsl:template match="text()">
        <xsl:value-of select="replace(., '\s+', ' ')"/>    
    </xsl:template> -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:body//tei:p">
        <xsl:text>{</xsl:text>
        <xsl:text>"id" : "</xsl:text>
        <xsl:value-of select="@xml:id"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"itemid" : "</xsl:text>
        <xsl:value-of select="//tei:body/tei:div/@xml:id"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"text": "</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
        <xsl:text>}</xsl:text>
        <xsl:variable name="precedingparas" select="count(preceding::tei:p)"/>
        <xsl:if test="$precedingparas &lt; $totalparas">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="tei:name">
        <span class="name">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:title">
        <span class="title">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:quote">
        <span class="quote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:teiHeader | tei:front | tei:bibl | tei:note | tei:rdg | tei:head"/>





</xsl:stylesheet>
