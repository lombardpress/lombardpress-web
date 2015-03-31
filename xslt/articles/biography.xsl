<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">

    <xsl:param name="projectfilesbase">../../projectfiles/</xsl:param>
    <xsl:param name="projectdata">projectdata.xml</xsl:param>
    <xsl:param name="biodir">Biography/</xsl:param>
    <xsl:param name="timelineuse">true</xsl:param>
    <xsl:param name="timelinename">PlaoulTimeLineTEI.xml</xsl:param>

    <xsl:template match="/">
        <html>
            
            <body>
                <div class="biodisplay">
                 <xsl:call-template name="teiHeaderInfo"/>   
                    
                <xsl:apply-templates/>
                    
                    <div class="footnotes">
                        <xsl:call-template name="footnote"/>
                    </div>
                </div>   
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template name="teiHeaderInfo">
        
        <div id="lbp-pub-info">
            <h2><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h2>
            <h4>By <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/></h4>
            <p>Edition: <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/@n"/> | <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/tei:date"/></p>
            <p>Original Publication: <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>, <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/>, <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/></p>
            <p>License Availablity: <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/@status"/>, <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/> </p>
            
        </div>
            
    </xsl:template>
    
    <xsl:template match="//tei:teiHeader">
        
    </xsl:template>
    
    <xsl:template name="footnote">
        <ul><xsl:for-each select="//tei:note">
            <xsl:variable name="id"><xsl:number count="//tei:note" level="any" format="1"/></xsl:variable>
            <li id="footnote{$id}"><a href="#footnotereference{$id}"><xsl:copy-of select="$id"/></a> -- <xsl:apply-templates/></li>
            
        </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="tei:ptr[@type='event']">
        <xsl:variable name="event"><xsl:value-of select="@target"/></xsl:variable>
        <xsl:variable name="xmlID" select="substring-after(@target, '#')"/>
        <xsl:variable name="bibList" select="document(./@target)//tei:bibl"/>
        <xsl:for-each select="$bibList">
            <xsl:choose>
                <xsl:when test="./@facs">
                    <xsl:variable name="facs" select="substring-after(./@facs, '#')"/>
            <xsl:element name="a">
                <xsl:attribute name="class">bibLive <xsl:value-of select="./@type"/></xsl:attribute>
                <xsl:attribute name="data-facs"><xsl:value-of select='$facs'/></xsl:attribute>
                <xsl:attribute name="data-bibid"><xsl:value-of select="./@xml:id"/></xsl:attribute>
                <xsl:attribute name="data-bibMainId"><xsl:value-of select="./@corresp"/></xsl:attribute>
                <xsl:apply-templates/></xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="a">
                        <xsl:attribute name="class">bib <xsl:value-of select="./@type"/></xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="./@corresp">
                <xsl:variable name="bibref"><xsl:value-of select="./@corresp"/></xsl:variable>
                <xsl:variable name="bibid"><xsl:value-of select="substring-after($bibref, '#')"/></xsl:variable>
                <xsl:text> </xsl:text><xsl:element name="a">
                    <xsl:attribute name="class">bibentry</xsl:attribute>
                    <xsl:attribute name="href">../bibliography/?target=<xsl:value-of select="$bibid"/></xsl:attribute>
                    <xsl:attribute name="target">Petrus Plaoul - Bibliography</xsl:attribute>
                    <xsl:attribute name="title">Full Bibliographical Information</xsl:attribute>BE</xsl:element>
            </xsl:if>
            <xsl:if test="./tei:ref">
                <xsl:text> | </xsl:text>
                <xsl:element name="a">
                    <xsl:attribute name="class">googlelink</xsl:attribute>
                    <xsl:attribute name="href"><xsl:value-of select="./tei:ref/@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="title">Google Books Link</xsl:attribute>GL</xsl:element>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="position() = last()">.</xsl:when>
                <xsl:otherwise>,</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:text> | </xsl:text>
        <a href="timelinelist.php?eid={$xmlID}" target="_blank">See Event</a>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <xsl:choose>
        <xsl:when test="./@corresp">
        <xsl:variable name="bibref"><xsl:value-of select="./@corresp"/></xsl:variable>
        <xsl:variable name="bibid"><xsl:value-of select="substring-after($bibref, '#')"/></xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="class">bib <xsl:value-of select="./@type"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
        <xsl:text> </xsl:text><xsl:element name="a">
            <xsl:attribute name="class">bibentry</xsl:attribute>
            <xsl:attribute name="href">../bibliography/?target=<xsl:value-of select="$bibid"/></xsl:attribute>
            <xsl:attribute name="target">Petrus Plaoul - Bibliography</xsl:attribute>
            <xsl:attribute name="title">Full Bibliographical Information</xsl:attribute>BE</xsl:element>
            
            <xsl:if test="./tei:ref">
                <xsl:text> | </xsl:text>
                <xsl:element name="a">
                    <xsl:attribute name="class">googlelink</xsl:attribute>
                    <xsl:attribute name="href"><xsl:value-of select="./tei:ref/@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="title">Google Books Link</xsl:attribute>GL</xsl:element>
            </xsl:if>
        </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:bibl[@type='timelineRef']">
        <xsl:variable name="sameAs" select="./@sameAs"/>
        <xsl:variable name="xmlID" select="substring-after($sameAs, '#')"/>
        <xsl:variable name="facsRef" select="document(concat($projectfilesbase, $biodir, $timelinename))//tei:bibl[@xml:id=$xmlID]/@facs"/>
        <xsl:variable name="facs" select="substring-after($facsRef, '#')"/>
        <xsl:choose>
            <xsl:when test="document(concat($projectfilesbase, $biodir, $timelinename))//tei:bibl[@xml:id=$xmlID]/@facs">
        <xsl:element name="a">
        <xsl:attribute name="class">bibLive <xsl:value-of select="./@type"/></xsl:attribute>
            <xsl:attribute name="data-facs"><xsl:value-of select="$facs"/></xsl:attribute>
            <xsl:attribute name="data-bibid"><xsl:value-of select="$xmlID"/></xsl:attribute>
            <xsl:apply-templates/></xsl:element>
            </xsl:when>
        <xsl:otherwise>
            <xsl:element name="a">
                <xsl:attribute name="class">bib <xsl:value-of select="./@type"/></xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:otherwise>
        </xsl:choose>
</xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>
    
   
    
    
    <xsl:template match="tei:head[@subtype='title']">
               
    </xsl:template>
    
    
    <xsl:template match="tei:head[@subtype='header2']">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>
    
    <xsl:template match="tei:bibl/tei:note">
    </xsl:template>
    <xsl:template match="tei:bibl/tei:ref">
    </xsl:template>
    
    <xsl:template match="tei:note">
        <xsl:variable name="id"><xsl:number count="//tei:note" level="any" format="1"/></xsl:variable>
        <sup><a href="#footnote{$id}" name="footnotereference{$id}" class="footnote"><xsl:copy-of select="$id"/></a></sup>
    </xsl:template>
    
    
    <xsl:template match="tei:hi[@rend='italic']">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <em><xsl:apply-templates/></em>
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
    

    
</xsl:stylesheet>
