<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
<xsl:output method="html"/>
    <xsl:template match="/">
        <div class="container archive">
                <xsl:apply-templates/>
        </div>



    </xsl:template>


    <xsl:template match="tei:teiHeader">

    </xsl:template>


    <xsl:template match="tei:head">
        <xsl:variable name="number" select="count(ancestor::tei:div)" />
        <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
        <xsl:variable name="fs"><xsl:value-of select="//tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>
        <xsl:element name="h{$number}">
            <xsl:attribute name="id">
                <xsl:value-of select="$id"/>
            </xsl:attribute>
                <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div">
        <div id="{@xml:id}"><xsl:apply-templates/></div>
    </xsl:template>


    <xsl:template match="tei:p">
      <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <p id="{@xml:id}"><span class="archive_num"><xsl:value-of select="$pn"/></span> <xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="tei:note | tei:rdg | tei:bibl ">

    </xsl:template>

</xsl:stylesheet>
