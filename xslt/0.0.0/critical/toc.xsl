<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>


            </body>


        </html>

    </xsl:template>


    <xsl:template match="tei:teiHeader">

    </xsl:template>


    <xsl:template match="tei:head[not(@type='questionTitle')]">
        <xsl:variable name="number" select="count(ancestor::tei:div)" />
        <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
        <xsl:variable name="fs"><xsl:value-of select="//tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>
        <xsl:element name="h{$number}"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        <xsl:element
                name="a"><xsl:attribute name="href">/text/<xsl:value-of
                select="$fs"/>#<xsl:value-of
                select="$id"/></xsl:attribute>
            <xsl:apply-templates select="node()" /></xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div">
        <div id="{@xml:id}" class="tocdiv"><xsl:apply-templates/></div>
    </xsl:template>


    <xsl:template match="//tei:p">


    </xsl:template>
</xsl:stylesheet>
