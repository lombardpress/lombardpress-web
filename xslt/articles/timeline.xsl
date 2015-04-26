<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" version="1.0">
    <xsl:output method="html"/>
    <xsl:param name="eid">none</xsl:param>
    <xsl:param name="bibQueryId">none</xsl:param>
    <xsl:param name="category">All</xsl:param>
    <xsl:param name="from">1300-00-00</xsl:param>
    <xsl:param name="to">1900-00-00</xsl:param>
    <xsl:param name="projectfilesbase">../../projectfiles/</xsl:param>
    <xsl:param name="projectdata">projectdata.xml</xsl:param>
    <xsl:param name="biodir">Biography/</xsl:param>
    <xsl:param name="timelinename">PlaoulTimeLineTEI.xml</xsl:param>
    <xsl:template match="/">
        
            
            <div>
              <h1>Event Timeline</h1>
                <xsl:choose>
                    <xsl:when test="not($eid = 'none')">
                        <xsl:apply-templates select="//t:event[@xml:id=$eid]"/>
                    </xsl:when>
                    <xsl:when test="not($bibQueryId = 'none')">
                        <xsl:apply-templates select="//t:event[t:bibl[@corresp[contains(., $bibQueryId)]]]"/>
                    </xsl:when>
                    
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="not($category = 'All')">
                                <xsl:variable name="fromDate" select="substring($from, 1, 4)"/>
                                <xsl:variable name="endDate" select="substring($to, 1, 4)"/>
                                <xsl:apply-templates select="//t:event[@type=$category or @subtype=$category][substring(@when | @from | @notBefore, 1, 4) &gt;= $fromDate][substring(@when, 1, 4) &lt;= $endDate]"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="fromDate" select="substring($from, 1, 4)"/>
                                <xsl:variable name="endDate" select="substring($to, 1, 4)"/>
                                <xsl:apply-templates select="//t:event[substring(@when | @from | @notBefore, 1, 4) &gt;= $fromDate][substring(@when | @from | @notBefore, 1, 4) &lt;= $endDate]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
                        
                    

            </div>
        
    </xsl:template>
    <xsl:template match="t:teiHeader">
        
    </xsl:template>
    <xsl:template match="t:event">
        <div class="event" id="{@xml:id}">
            <div class="eventHeader" data-eid="{@xml:id}">
                <p>
                    <xsl:value-of select="./@when | ./@from | ./@notBefore"/>
                    <xsl:if test="./@notBefore"> (Not Before) </xsl:if>
                    <xsl:if test="./@to">
                        -- <xsl:value-of select="./@to"/>
                    </xsl:if>
                    
                    <xsl:if test="./@notAfter">
                        -- <xsl:value-of select="./@notAfter"/> (Not After)
                    </xsl:if>
                    
                    | <xsl:element name="span">
                        <xsl:attribute name="class">lbp-label</xsl:attribute>
                        <xsl:value-of select="./t:label"/>
                    </xsl:element>
                    |
                    <xsl:element name="span">
                    <xsl:attribute name="class"><xsl:value-of select="./@type"/> Category</xsl:attribute>
                    <xsl:value-of select="./@type"/>
                </xsl:element>
                <xsl:if test="./@subtype">
                    | <xsl:element name="span">
                        <xsl:attribute name="class"><xsl:value-of select="./@subtype"/> Category</xsl:attribute>
                        <xsl:value-of select="./@subtype"/>
                    </xsl:element>
                </xsl:if>
                </p>
            </div>
            <div class="eventBody">
                <div class="eventDesc">
                <xsl:apply-templates/>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="t:label">
        
    </xsl:template>
    <xsl:template match="t:desc">
        <p class="eventDescPara"><span style="font-weight: bold;">Event Description: </span><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="t:bibl">   
        <p>
            <xsl:variable name="facsRef" select="./@facs"/>
            <xsl:variable name="facs" select="substring-after($facsRef, '#')"/>
            <span class="sourceType"><xsl:value-of select="@type"/>: </span>
            <xsl:choose>
            <xsl:when test="./@facs">
                <xsl:element name="span">
                    <xsl:attribute name="class">bibLive eventList <xsl:value-of select="./@type"/></xsl:attribute>
                    <xsl:attribute name="data-facs"><xsl:value-of select="$facs"/></xsl:attribute>
                    <xsl:attribute name="data-bibid"><xsl:value-of select="./@xml:id"/></xsl:attribute>
                    <xsl:attribute name="data-bibMainId"><xsl:value-of select="./@corresp"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="class">bib eventList <xsl:value-of select="./@type"/></xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
                
            </xsl:otherwise>
        </xsl:choose>
            <xsl:if test="./@corresp">
                <xsl:variable name="bibref"><xsl:value-of select="./@corresp"/></xsl:variable>
                <xsl:variable name="bibid"><xsl:value-of select="substring-after($bibref, '#')"/></xsl:variable>
                <xsl:text> </xsl:text><xsl:element name="a">
                    <xsl:attribute name="class">bibentry</xsl:attribute>
                    <xsl:attribute name="href">/articles/bibliography/#<xsl:value-of select="$bibid"/></xsl:attribute>
                    <xsl:attribute name="target">Petrus Plaoul - Bibliography</xsl:attribute>
                    <xsl:attribute name="title">Full Bibliographical Information</xsl:attribute>BE</xsl:element>
            </xsl:if>
            <xsl:if test="./t:ref">
                <xsl:element name="a">
                    <xsl:attribute name="class">googlelink</xsl:attribute>
                    <xsl:attribute name="href"><xsl:value-of select="./t:ref/@target"/></xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="title">Google Books Link</xsl:attribute>GL</xsl:element>
            </xsl:if>
        </p>
        <p style="font-size: 12px; margin-top: 0px; padding-left: 15px;"><xsl:value-of select="./t:note"/></p>
    </xsl:template>
    
    
    <xsl:template match="t:event/t:note">
        <p style="margin-top: 3px; border-top: 1px dashed black; padding: 3px;">Event Note: <xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="t:bibl/t:note">
        
    </xsl:template>
    <xsl:template match="t:ref[@type='timelineCrossReference']">
        <xsl:variable name="eid" select="substring-after(./@target, '#')"></xsl:variable>
        <a class="timelineCrossReference" data-eid='{$eid}'><xsl:apply-templates/></a>
    </xsl:template>
    <xsl:template match="t:ref">
    <!--    <a href="{@target}"><xsl:apply-templates/></a> -->
    </xsl:template>
</xsl:stylesheet>