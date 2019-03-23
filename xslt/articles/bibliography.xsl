<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
    <xsl:param name="type">all</xsl:param>
    <xsl:param name="subtype">all</xsl:param>
    <xsl:param name="file-path"/>

<xsl:output method="html"/>

   <xsl:param name="id">all</xsl:param>

<xsl:template match="/">


<div>
      <div id="lbp-review-display" data-file-url="{$file-path}"/>
      <xsl:choose>
          <xsl:when test="not($id = 'all')">
              <xsl:apply-templates select="//tei:biblStruct[@xml:id=$id]"/>
          </xsl:when>
          <xsl:when test="$type = 'all' and $subtype = 'all'">
              <xsl:apply-templates/>
          </xsl:when>
          <xsl:when test="$type = 'Secondary'">
              <xsl:apply-templates select="//tei:listBibl[@type=$type]"/>
          </xsl:when>

          <xsl:otherwise>
              <xsl:apply-templates select="//tei:listBibl[@type=$type][@subtype=$subtype]"/>
          </xsl:otherwise>
      </xsl:choose>


</div>

</xsl:template>

<xsl:template match="tei:teiHeader">

</xsl:template>

<xsl:template match="tei:listBibl">
    <div>
        <h2><xsl:value-of select="./tei:head"/></h2>
    <xsl:for-each select="./tei:biblStruct">
        <xsl:sort select=".//tei:author/tei:surname | .//tei:author/tei:name | .//tei:editor/tei:surname"/>
        <xsl:sort select=".//tei:imprint/tei:date"/>

        <xsl:call-template name="format"/>
    </xsl:for-each>
    </div>
</xsl:template>

    <xsl:template match="tei:biblStruct" name="format">
    <div class="bibWrapper">
        <div class="bibEntry">
        <p id="{@xml:id}">

    <xsl:choose>
        <xsl:when test="@type = 'journalArticle' or @type = 'bookSection'">
            <xsl:choose>
                <xsl:when test="count(./tei:analytic/tei:author) > 1">
                    <xsl:value-of select="./tei:analytic/tei:author[1]/tei:surname"/>,
                    <xsl:value-of select="./tei:analytic/tei:author[1]/tei:forename"/> and
                    <xsl:value-of select="./tei:analytic/tei:author[2]/tei:forename"/><xsl:text> </xsl:text>
                    <xsl:value-of select="./tei:analytic/tei:author[2]/tei:surname"/>,
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./tei:analytic/tei:author/tei:surname"/>,
                    <xsl:value-of select="./tei:analytic/tei:author/tei:forename"/>,
                </xsl:otherwise>
            </xsl:choose>
            "<xsl:value-of select="./tei:analytic/tei:title"/>,"
            <xsl:choose>
                <xsl:when test="@type = 'journalArticle'">
                    <span class="journalTitle"><xsl:value-of select="./tei:monogr/tei:title"/></span>,
                    <xsl:value-of select="./tei:monogr/tei:imprint/tei:biblScope[@type='vol']"/>
                    (<xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>),
                    <xsl:value-of select="./tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
                </xsl:when>
                <xsl:when test="@type = 'bookSection'">
                    in <span class="bookTitle"><xsl:value-of select="./tei:monogr/tei:title"/></span>,
                    <xsl:if test="./tei:monogr/tei:editor">

                        <xsl:choose>
                        <xsl:when test="count(./tei:monogr/tei:editor) = 3 ">
                            eds.
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:forename"/><xsl:text> </xsl:text>
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:surname"/>,
                            <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:forename"/><xsl:text> </xsl:text>
                            <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:surname"/>, and
                            <xsl:value-of select="./tei:monogr/tei:editor[3]/tei:forename"/><xsl:text> </xsl:text>
                            <xsl:value-of select="./tei:monogr/tei:editor[3]/tei:surname"/>,
                        </xsl:when>
                        <xsl:when test="count(./tei:monogr/tei:editor) = 2">
                            eds.
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:forename"/><xsl:text> </xsl:text>
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:surname"/> and
                            <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:forename"/><xsl:text> </xsl:text>
                            <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:surname"/>,
                        </xsl:when>
                        <xsl:otherwise>
                            ed.
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:forenname"/>
                            <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:surname"/>,
                        </xsl:otherwise>
                    </xsl:choose>
                    </xsl:if>

                    (<xsl:value-of select="./tei:monogr/tei:imprint/tei:pubPlace"/>,
                    <xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>),
                    <xsl:value-of select="./tei:monogr/tei:imprint/tei:biblScope[@type='pp']"/>
                </xsl:when>
            </xsl:choose>
            <xsl:value-of select="./tei:monogr/teititle"/>
        </xsl:when>
    <xsl:when test="@type = 'book'">
        <xsl:choose>
            <xsl:when test="./tei:monogr/tei:author/tei:surname">
                <xsl:value-of select="./tei:monogr/tei:author/tei:surname"/>,
                <xsl:value-of select="./tei:monogr/tei:author/tei:forename"/>,
            </xsl:when>
        <xsl:when test="not(./tei:monogr/tei:author)">
            <xsl:choose >
                <xsl:when test="count(./tei:monogr/tei:editor) > 1">
                        <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:surname"/>,
                        <xsl:value-of select="./tei:monogr/tei:editor[1]/tei:forename"/> and
                        <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:forename"/><xsl:text> </xsl:text>
                        <xsl:value-of select="./tei:monogr/tei:editor[2]/tei:surname"/>,
                </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="./tei:monogr/tei:editor/tei:surname"/>,
                <xsl:value-of select="./tei:monogr/tei:editor/tei:forename"/>,
            </xsl:otherwise>
            </xsl:choose>

        </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="./tei:monogr/tei:author/tei:name "/>,
            </xsl:otherwise>
        </xsl:choose>

        <span class="bookTitle"><xsl:value-of select="./tei:monogr/tei:title"/></span>,
        <xsl:if test="./tei:monogr/tei:imprint/tei:pubPlace">
        <xsl:value-of select="./tei:monogr/tei:imprint/tei:pubPlace"/>,
        </xsl:if>
        <xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>
    </xsl:when>
        <xsl:when test="@type = 'manuscript'">
            <xsl:if test="./tei:monogr/tei:author/tei:name">
                <xsl:value-of select="./tei:monogr/tei:author/tei:name"/>,

            </xsl:if>
            <span class="bookTitle"><xsl:value-of select="./tei:monogr/tei:title"/></span>,
            <xsl:value-of select="./tei:monogr/tei:imprint/tei:pubPlace"/>
            <xsl:if test="./tei:monogr/tei:imprint/tei:date">
            , <xsl:value-of select="./tei:monogr/tei:imprint/tei:date"/>
            </xsl:if>
        </xsl:when>
    </xsl:choose>

    </p>
        </div>
        <div class="bibMenu">
            <xsl:if test="./tei:note">
                <p><a class="viewNotes">View Notes</a></p>
            </xsl:if>
        </div>
        <xsl:if test="./tei:note">

            <div class="bibNotes">
            <xsl:for-each select="./tei:note">
                <xsl:choose>
                    <xsl:when test="./@type='googleUrl'">
                        <p>
                            <xsl:element name="a">
                                <xsl:attribute name="class">googleLink</xsl:attribute>
                                <xsl:attribute name="target">_blank</xsl:attribute>
                                <xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
                                <xsl:text>Google Books Link: </xsl:text><xsl:value-of select="."/>
                            </xsl:element>
                        </p>
                    </xsl:when>
                <xsl:otherwise>
                <p><xsl:apply-templates/></p>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>

            </div>
        </xsl:if>

    </div>
</xsl:template>



</xsl:stylesheet>
