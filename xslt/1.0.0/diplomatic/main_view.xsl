<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="html"/>
  <!-- params -->
  <!-- check global site setting for images -->
  <xsl:param name="show-images">true</xsl:param>

  <xsl:param name="default-ms-image">reims</xsl:param>

  <!-- this param needs to change if, for example, you want the show xml function to display XML for something other than "critical"; Alternatively, this slug could be found somewhere in the TEI document being processed -->
  <xsl:param name="default-msslug">critical</xsl:param>
  <xsl:param name="file-path"/>

  <!-- variables-->
  <xsl:variable name="itemid"><xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>

  <!-- root template -->
  <xsl:template match="/">
    <!-- title/publication info -->
    <xsl:call-template name="teiHeaderInfo"/>

    <!-- transform body of text -->
    <xsl:apply-templates/>

    <!-- prepare footnotes -->

    <!-- prepare variants -->

  </xsl:template>

  <!-- clear teiHeader -->
  <xsl:template match="tei:teiHeader"></xsl:template>

  <!-- heading template -->
  <xsl:template match="tei:head">
    <!-- no supplied headers in documentary transcription; need to specifiy supplied if there are headers present in the text -->
  </xsl:template>

  <xsl:template match="tei:div">
    <div id="{@xml:id}" class="plaoulparagraph"><xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <xsl:variable name="pid"><xsl:value-of select="@xml:id"/></xsl:variable>

    <div class='para_wrap' id='pwrap_{@xml:id}' style="clear: both; float: none;">
      <p id="{@xml:id}" class="plaoulparagraph"><span id="pn{$pn}" class="paragraphnumber"><xsl:number level="any" from="tei:text"/></span><xsl:apply-templates/>
      <xsl:if test="./@xml:id">
        <span class="lbp-paragraphmenu">
          <span class="glyphicon glyphicon-tasks" aria-hidden="true"></span>
        </span>
      </xsl:if>
      </p>
      <xsl:if test="./@xml:id">
        <nav class="navbar navbar-default paradiv" id="menu_{@xml:id}" style="display: none;">
          <div class="navbar-header navbar-right">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#para-navbar-collapse-{@xml:id}">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
          </div>
          <div class="collapse navbar-collapse" id="para-navbar-collapse-{@xml:id}">
            <ul class="nav navbar-nav">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Comments<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#" class='js-view-comments' data-itemid="{$itemid}" data-pid="{@xml:id}">View Comments</a></li>
                  <li><a href="#" class='js-new-comment' data-itemid="{$itemid}" data-pid="{@xml:id}">Leave a Comment</a></li>
                </ul>
              </li>
              <li><a href="#" class="js-show-para-image-zoom-window" data-expressionid="{@xml:id}"  data-msslug="{$default-ms-image}">Manuscript Images</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Paragraph Text Tools<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#" class='js-show-paragraph-collation' data-itemid="{@xml:id}">Collation</a></li>
                  <li><a href="#" class='js-show-paragraph-comparison' data-itemid="{@xml:id}">Compare</a></li>
                  <li><a href="#" class='js-show-paragraph-xml' data-itemid="{$itemid}" data-pid="{@xml:id}" data-msslug="{$default-msslug}">XML</a></li>
                  <li><a href="#" class='js-show-paragraph-info' data-itemid="{$itemid}" data-pid="{@xml:id}">Paragraph Info</a></li>

                  <!--<li><a class='js-show-variants' data-itemid="{$itemid}" data-pid="{@xml:id}">Variants</a></li> -->
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </xsl:if>
    </div>
  </xsl:template>

  <!-- name template -->
  <xsl:template match="tei:name">
    <xsl:variable name="ref"><xsl:value-of select="./@ref"/></xsl:variable>
    <xsl:variable name="refID"><xsl:value-of select="substring-after($ref, '#')"/></xsl:variable>
    <span class="lbp-documentary-name" data-name="{$refID}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- title template -->
  <xsl:template match="tei:title">
    <xsl:variable name="ref"><xsl:value-of select="./@ref"/></xsl:variable>
    <xsl:variable name="refID"><xsl:value-of select="substring-after($ref, '#')"/></xsl:variable>
    <span class="lbp-documentary-title" data-title="{$refID}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- quote template -->
  <xsl:template match="tei:quote">
      <xsl:variable name="quoterefid" select="translate(./@ana, '#', '')"/>
    <span id="{@xml:id}" class="lbp-documentary-quote" data-quote="{$quoterefid}">
      <xsl:text/>
      <xsl:apply-templates/>
      <xsl:text/>
    </span>
  </xsl:template>

  <!-- ref template -->
  <xsl:template match="tei:ref">
    <xsl:variable name="refid" select="translate(./@ana, '#', '')"/>
    <span id="{@xml:id}" class="lbp-documentary-ref" data-ref="{$refid}">
      <xsl:text/>
      <xsl:apply-templates/>
      <xsl:text/>
    </span>
  </xsl:template>

  <!-- unclear template -->
  <xsl:template match="tei:unclear">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span  class="lbp-unclear" data-text="{$text}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- templates to deal with orig vs normalized -->
  <xsl:template match="tei:choice">
    <span class="lbp-choice">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:orig">
    <span class="lbp-orig">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:reg">
    <span class="lbp-reg" style="display: none;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- templates to deal with corrections -->
  <xsl:template match="tei:corr">
    <span class="lbp-corr">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:add">
    <span class="lbp-add">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <xsl:template match="tei:del">
    <span class="lbp-del">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- templates for glypsh -->
  <xsl:template match="tei:g[@ref='#dbslash']">
    <span class="lbp-glyph lbp-dbslash">//</span><xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="tei:g[@ref='#slash']">
    <span class="lbp-glyph lbp-slash">/</span><xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:g[@ref='#dbdash']">
    <span class="lbp-glyph lbp-dbdash">=</span><xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="tei:g[@ref='#dash']">
    <span class="lbp-glyph lbp-dash">=</span><xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="tei:g[@ref='#pilcrow']">
    <span class="lbp-glyph lbp-pilcrow">&#182;</span><xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>





  <!-- clear note desc bib template -->
  <xsl:template match="tei:note | tei:desc | tei:bibl"></xsl:template>

  <xsl:template match="tei:cb">
    <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
    <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
    <!-- get side from previous pb -->
    <xsl:variable name="folio-and-side">
      <!-- condition to get preceding sibling when needed -->
      <xsl:choose>
        <xsl:when test="./preceding-sibling::tei:pb[1]">
          <xsl:value-of select="./preceding-sibling::tei:pb[@ed=$hashms][1]/@n"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="./preceding::tei:pb[@ed=$hashms][1]/@n"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- <xsl:variable name="length"><xsl:value-of select="string-length($folio-and-side)-2"/></xsl:variable> -->
    <xsl:variable name="folio">
      <xsl:choose>
        <xsl:when test="not(contains($folio-and-side, '-'))">
          <xsl:value-of select="$folio-and-side"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="substring-before($folio-and-side, '-')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- <xsl:variable name="side_column"><xsl:value-of select="substring($fullcn, $length+1)"/></xsl:variable> -->
    <xsl:variable name="column"><xsl:value-of select="./@n"/></xsl:variable>
    <xsl:variable name="side"><xsl:value-of select="substring-after($folio-and-side, '-')"/></xsl:variable>

    <xsl:variable name="surfaceid">
      <xsl:value-of select="concat($default-ms-image, '/', $folio, $side)"/>
    </xsl:variable>
    <xsl:variable name="canvasid">
      <xsl:choose>
        <xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base">
          <xsl:variable name="canvasbase" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base"/>
          <xsl:variable name="canvasend" select="./@select"/>
          <xsl:value-of select="concat($canvasbase, $canvasend)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('http://scta.info/iiif/', 'xxx-', $default-ms-image, '/canvas/', $ms, $folio, $side)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- get preceding paragraph id -->
    <xsl:variable name="expressionid" select="./preceding::tei:p/@xml:id"/>

    <span class="lbp-folionumber">
      <xsl:choose>
        <xsl:when test="$show-images = 'true'">
          <a href="#" class="js-show-folio-image" data-canvasid="{$canvasid}" data-surfaceid="{$surfaceid}" data-msslug="{$default-ms-image}" data-expressionid="{$expressionid}">
            <xsl:value-of select="$ms"/>
            <xsl:value-of select="$folio"/>
            <xsl:value-of select="concat($side, $column)"/>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$ms"/>
          <xsl:value-of select="$folio"/>
          <xsl:value-of select="concat($side, $column)"/>
        </xsl:otherwise>
      </xsl:choose>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="tei:pb">
    <xsl:if test="not(//tei:cb)">
      <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
      <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
      <xsl:variable name="folio-and-side"><xsl:value-of select="@n"/></xsl:variable>
      <!-- this variable gets length of Ms abbrev and folio number after substracting side -->
      <xsl:variable name="folio">
        <xsl:choose>
          <xsl:when test="not(contains($folio-and-side, '-'))">
            <xsl:value-of select="$folio-and-side"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring-before($folio-and-side, '-')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- this variable separates isolates folio number by skipping msAbbrev and then not including side designation -->
      <xsl:variable name="side"><xsl:value-of select="substring-after($folio-and-side, '-')"/></xsl:variable>
      <!-- this desgination gets side by skipping lenghth of msAbbrev and folio number and then getting the first character that occurs -->
      <xsl:variable name="break-ms-slug" select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:listWit[1]/tei:witness[1][@xml:id=$ms]/@n"/>
      <!-- get preceding paragraph id -->
      <xsl:variable name="expressionid" select="./preceding::tei:p/@xml:id"/>

      <xsl:variable name="surfaceid">
        <xsl:value-of select="concat($default-ms-image, '/', $folio, $side)"/>
      </xsl:variable>

      <xsl:variable name="canvasid">
        <xsl:choose>
          <xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base">
            <xsl:variable name="canvasbase" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base"/>
            <xsl:variable name="canvasend" select="./@select"/>
            <xsl:value-of select="concat($canvasbase, $canvasend)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('http://scta.info/iiif/', 'xxx-', $default-ms-image, '/canvas/', $ms, $folio, $side)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>



      <span class="lbp-folionumber">
        <xsl:choose>
          <xsl:when test="$show-images = 'true'">
            <a href="#" class="js-show-folio-image" data-canvasid="{$canvasid}" data-surfaceid="{$surfaceid}" data-msslug="{$default-ms-image}" data-expressionid="{$expressionid}">
            <xsl:value-of select="$ms"/>
            <xsl:value-of select="$folio"/>
            <xsl:value-of select="$side"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$ms"/>
            <xsl:value-of select="$folio"/>
            <xsl:value-of select="$side"/>
          </xsl:otherwise>
        </xsl:choose>
      </span>
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="tei:note[@type='marginal-note']">
    <xsl:variable name="place" select="./@place"/>
    <xsl:variable name="preceding-line" select="./preceding::tei:lb[1]"/>
    <xsl:variable name="number-of-notes-after-this-line"><xsl:value-of select="(count($preceding-line//following::tei:note) - count(.//following::tei:note)) -1"/></xsl:variable>
    <!-- <xsl:variable name="note-paragraph-count"><xsl:number level="single" count="tei:note[@type='marginal-note']"/></xsl:variable> -->
    <xsl:variable name="top-offset"><xsl:value-of select="$number-of-notes-after-this-line * 20"/></xsl:variable>
    <xsl:variable name="left-offset"><xsl:value-of select="($number-of-notes-after-this-line * 20) + 150"/></xsl:variable>
    <xsl:variable name="note-zindex"><xsl:value-of select="($number-of-notes-after-this-line + 1) * .1"/></xsl:variable>
    <xsl:variable name="top-style-setting"><xsl:value-of select="concat($top-offset, 'px')"/></xsl:variable>
    <xsl:variable name="left-style-setting"><xsl:value-of select="concat('-', $left-offset, 'px')"/></xsl:variable>
      <span class="lbp-marginal-note" data-place="{$place}" style="top: {$top-style-setting}; left: {$left-style-setting}; z-index: {$note-zindex}"><xsl:apply-templates/></span>
  </xsl:template>


  <!-- named templates -->

  <!-- header info -->
  <xsl:template name="teiHeaderInfo">
    <div id="lbp-pub-info">
      <h2><span id="sectionTitle" class="sectionTitle"><xsl:value-of select="//tei:titleStmt/tei:title"/></span></h2>
      <h3>Diplomatic Transcription</h3>
      <h4>By <xsl:text> </xsl:text><xsl:value-of select="//tei:titleStmt/tei:author"/></h4>
      <div style="font-size: 12px; max-height: 300px; overflow: scroll">
        <xsl:if test="//tei:titleStmt/tei:editor/text() or //tei:titleStmt/tei:editor/@ref">
          <p>Edited by <xsl:text> </xsl:text>
            <xsl:for-each select="//tei:titleStmt/tei:editor">
              <xsl:choose>
                <xsl:when test="position() = last()">
                  <span><xsl:value-of select="."/></span><xsl:text/>
                </xsl:when>
                <xsl:otherwise>
                  <span><xsl:value-of select="."/></span><xsl:text>, </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </p>
        </xsl:if>
        <xsl:if test="//tei:titleStmt//tei:respStmt">
          <div id="lbp-contributors">
            <p>Contributors:</p>
            <p style="padding-left: 10px">
              <xsl:for-each select="//tei:titleStmt/tei:respStmt">
                <xsl:choose>
                  <xsl:when test="./tei:resp/@when">
                    - <span><xsl:value-of select="./tei:name"/></span>,
                    <span><xsl:value-of select="normalize-space(./tei:resp)"/></span>,
                    <span><xsl:value-of select="./tei:resp/@when"/></span>
                    <xsl:text> </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    - <span><xsl:value-of select="./tei:name"/></span>,
                    <span><xsl:value-of select="normalize-space(./tei:resp)"/></span>
                    <xsl:text> </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </p>
          </div>
        </xsl:if>
        <p>Edition: <span id="editionNumber"><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/@n"/></span> | <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/tei:date"/></p>
        <p>Authority:
          <xsl:choose>
            <xsl:when test="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority/tei:ref">
              <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority"/>: <a href="{//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority/tei:ref/@target}"><xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority/tei:ref/@target"/></a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:authority"/>
            </xsl:otherwise>
          </xsl:choose>
        </p>
        <p>License Availablity: <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/@status"/>, <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/> </p>
        <div id="lbp-review-display" data-file-url="{$file-path}"></div>
        <p style="display: none;"><span id="filestem"><xsl:value-of select="//tei:body/tei:div/@xml:id"/></span></p>
        <xsl:if test="//tei:sourceDesc/tei:listBibl or //tei:sourceDesc/tei:listWit">
          <div id="sources">
            <p>Sources:</p>
            <xsl:for-each select="//tei:sourceDesc/tei:listWit/tei:witness[@n|text()]">
              <p style="padding-left: 10px"><xsl:value-of select="./@xml:id"/>: <xsl:value-of select="."/></p>
            </xsl:for-each>
            <xsl:for-each select="//tei:sourceDesc/tei:listBibl/tei:bibl">
              <p style="padding-left: 10px"><xsl:value-of select="./@xml:id"/>: <xsl:value-of select="."/></p>
            </xsl:for-each>
          </div>
        </xsl:if>
      </div>

    </div>
  </xsl:template>

</xsl:stylesheet>
