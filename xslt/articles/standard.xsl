<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml"/>
    
    <xsl:template match="/">
        <html>
            <head></head>
            <body>
                <xsl:call-template name="about-toc"/>
        <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:teiHeader">
        
    </xsl:template>
    <xsl:template match="tei:head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    <xsl:template match="tei:div">
        <div class="{@type}" id="{@xml:id}" style="{@style}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:p">
        <p class="{@ana}" id="{@xml:id}" style="{@style}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:ref">
        <a href="{@target}" style="{@style}">
            <xsl:apply-templates/></a>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='italic']">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template name="about-toc">
        <div id="about-toc">
        <xsl:for-each select="//tei:div[@type='aboutsection']">
            <xsl:variable name="sectionid" select="concat('#', @xml:id)"/>
            <h2 class="about-toc-item"><a href="{$sectionid}"><xsl:value-of select="./tei:head"/></a></h2>
        </xsl:for-each>
        </div>
    </xsl:template>
    
</xsl:stylesheet>