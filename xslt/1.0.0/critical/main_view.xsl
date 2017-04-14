<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="html"/>
  <!-- params -->
  <!-- check global site setting for images -->
  <xsl:param name="show-images">true</xsl:param>

  <xsl:param name="default-ms-image">reims</xsl:param>

  <!-- this param needs to change if, for example, you want the show xml function to display XML for something other than "critical"; Alternatively, this slug could be found somewhere in the TEI document being processed -->
  <xsl:param name="default-msslug">critical</xsl:param>

  <!-- these params provide different language locales inherited from rails app -->
  <xsl:param name="by_phrase">By</xsl:param>
  <xsl:param name="edited_by_phrase">By</xsl:param>



  <!-- variables-->
  <xsl:variable name="itemid"><xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>

  <!-- root template -->
  <xsl:template match="/">
    <!-- title/publication info -->
    <xsl:call-template name="teiHeaderInfo"/>

    <!-- transform body of text -->
  	<xsl:apply-templates/>

    <!-- prepare footnotes -->
    <div class="footnotes">
      <h1>Apparatus Fontium</h1>
      <xsl:call-template name="footnotes"/>
    </div>
    <!-- prepare variants -->
    <div class="variants">
      <h1>Apparatus Criticus</h1>
      <xsl:call-template name="variants"/>
    </div>
  </xsl:template>

  <!-- clear teiHeader -->
  <xsl:template match="tei:teiHeader"></xsl:template>

  <!-- heading template -->
  <xsl:template match="tei:head">
    <xsl:variable name="number" select="count(ancestor::tei:div)" />
    <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
    <xsl:variable name="parent-div-id"><xsl:value-of select="./parent::tei:div/@xml:id"/></xsl:variable>

    <xsl:element name="h{$number}"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
      <xsl:apply-templates/>
      <!-- TODO: add button to get info about a section
        <xsl:if test="./parent::tei:div[@xml:id] and not(./type='questionTitle')">
          <a href="#" class='js-show-paragraph-info' data-itemid="{$itemid}" data-pid="{$parent-div-id}"><span class="glyphicon glyphicon-tasks" aria-hidden="true"></span></a>
        </xsl:if>
      -->
    </xsl:element>
  </xsl:template>

  <xsl:template match="tei:div">
    <div id="{@xml:id}" class="plaoulparagraph"><xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="tei:p">
    <xsl:variable name="pn"><xsl:number level="any" from="tei:text"/></xsl:variable>
    <xsl:variable name="pid"><xsl:value-of select="@xml:id"/></xsl:variable>

    <div class='para_wrap' id='pwrap_{@xml:id}' style="clear: both; float: none;">
      <p id="{@xml:id}" class="plaoulparagraph">
      <span id="pn{$pn}" class="paragraphnumber">
        <xsl:number level="any" from="tei:text"/>
      </span>
      <xsl:apply-templates/>
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
              <xsl:if test="$show-images = 'true'">
                <li><a href="#" class="js-show-para-image-zoom-window" data-expressionid="{@xml:id}" data-msslug="{$default-ms-image}">Manuscript Images</a></li>
              </xsl:if>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Paragraph Text Tools<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#" class='js-show-paragraph-variants' data-itemid="{$itemid}" data-pid="{@xml:id}">Variants</a></li>
                  <li><a href="#" class='js-show-paragraph-notes' data-itemid="{$itemid}" data-pid="{@xml:id}">Notes</a></li>
                  <li><a href="#" class='js-show-paragraph-collation' data-itemid="{@xml:id}">Collation</a></li>
                  <li><a href="#" class='js-show-paragraph-xml' data-itemid="{$itemid}" data-pid="{@xml:id}" data-msslug="{$default-msslug}">XML</a></li>
                  <li><a href="#" class='js-show-paragraph-info' data-itemid="{$itemid}" data-pid="{@xml:id}">Paragraph Info</a></li>

                </ul>
              </li>
              <!--<li><a>How To Cite</a></li> -->
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
    <span class="lbp-name" data-name="{$refID}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- title template -->
  <xsl:template match="tei:title">
    <xsl:variable name="ref"><xsl:value-of select="./@ref"/></xsl:variable>
    <xsl:variable name="refID"><xsl:value-of select="substring-after($ref, '#')"/></xsl:variable>
    <span class="lbp-title" data-title="{$refID}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- quote template -->
  <xsl:template match="tei:quote">
      <xsl:variable name="quoterefid" select="translate(./@ana, '#', '')"/>
    <span id="{@xml:id}" class="lbp-quote" data-quote="{$quoterefid}">
      <xsl:text>"</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>"</xsl:text>
    </span>
  </xsl:template>

  <!-- ref template -->
  <xsl:template match="tei:ref">
    <xsl:variable name="refid" select="translate(./@ana, '#', '')"/>
    <xsl:variable name="corresp" select="translate(./@corresp, '#', '')"/>
    <span id="{@xml:id}" class="lbp-ref" data-ref="{$refid}" data-corresp="{$corresp}">
      <xsl:text/>
      <xsl:apply-templates/>
      <xsl:text/>
    </span>
  </xsl:template>

  <xsl:template match="tei:bibl/tei:ref">
    <xsl:choose>
      <xsl:when test="contains(./@target, 'http://scta.info/resource/')">
        <a href="{@target}" data-url="{@target}" class='js-show-reference-paragraph'><xsl:apply-templates/></a> <a href="{@target}" target="_blank"> [SCTA Entry] </a>
      </xsl:when>
      <xsl:otherwise>
        <a href="{@target}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- unclear template -->
  <xsl:template match="tei:unclear">
    <xsl:variable name="text"><xsl:value-of select="./text()"/></xsl:variable>
    <span class="lbp-unclear" data-text="{$text}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- app template -->
  <xsl:template match="tei:app">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- clear rdg template -->
  <xsl:template match="tei:rdg"></xsl:template>

  <!-- clear note desc bib template -->
  <xsl:template match=" tei:note | tei:desc | tei:bibl"></xsl:template>

  <xsl:template match="tei:cb">
    <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
    <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
  	<!-- get side from previous pb -->
    <xsl:variable name="folio-and-side">
      <!-- TODO preceding not working in column A cases where pagebreak is preceding sibling -->
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
    <xsl:variable name="break-ms-slug" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@n"/>
    <xsl:variable name="surfaceid">
      <xsl:value-of select="concat($break-ms-slug, '/', $folio, $side)"/>
    </xsl:variable>
    <xsl:variable name="canvasid">
      <xsl:choose>
        <xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base">
          <xsl:variable name="canvasbase" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base"/>
          <xsl:variable name="canvasend" select="./preceding::tei:pb[@ed=$hashms]/@facs"/>
          <xsl:value-of select="concat($canvasbase, $canvasend)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('http://scta.info/iiif/', 'xxx-', $break-ms-slug, '/canvas/', $ms, $folio, $side)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!-- get preceding paragraph id -->
    <xsl:variable name="expressionid" select="./preceding::tei:p/@xml:id"/>



    <span class="lbp-folionumber">
      <!-- data-msslug needs to get info directly from final; default will not work -->
      <xsl:choose>
        <xsl:when test="$show-images = 'true'">
          <a href="#" class="js-show-folio-image" data-canvasid="{$canvasid}" data-surfaceid="{$surfaceid}" data-msslug="{$break-ms-slug}" data-expressionid="{$expressionid}">
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
	    <!-- <xsl:variable name="length"><xsl:value-of select="string-length($fullcn)-1"/></xsl:variable> -->
	    <!-- this variable separates isolates folio number by skipping msAbbrev and then not including side designation -->
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
	    <!-- this desgination gets side by skipping lenghth of msAbbrev and folio number and then getting the first character that occurs -->
	    <xsl:variable name="side"><xsl:value-of select="substring-after($folio-and-side, '-')"/></xsl:variable>

	    <!-- this variable gets the msslug associated with ms initial in the teiHeader -->
	    <xsl:variable name="break-ms-slug" select="/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:sourceDesc[1]/tei:listWit[1]/tei:witness[1][@xml:id=$ms]/@n"/>
	    <!-- get preceding paragraph id -->
	    <xsl:variable name="expressionid" select="./preceding::tei:p/@xml:id"/>

      <xsl:variable name="surfaceid">
        <xsl:value-of select="concat($break-ms-slug, '/', $folio, $side)"/>
      </xsl:variable>

      <xsl:variable name="canvasid">
	      <xsl:choose>
	        <xsl:when test="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base">
	          <xsl:variable name="canvasbase" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listWit/tei:witness[@xml:id=$ms]/@xml:base"/>
	          <xsl:variable name="canvasend" select="./@facs"/>
	          <xsl:value-of select="concat($canvasbase, $canvasend)"/>
	        </xsl:when>
	        <xsl:otherwise>
	          <!-- the 'xxx-' is used to be replaced in the rails app with the commentary slug -->
	          <xsl:value-of select="concat('http://scta.info/iiif/', 'xxx-', $break-ms-slug, '/canvas/', $ms, $folio, $side)"/>
	        </xsl:otherwise>
	      </xsl:choose>
	    </xsl:variable>

	    <span class="lbp-folionumber">
	      <!-- data-msslug needs to get info directly from final; default will not work -->
	      <xsl:choose>
	        <xsl:when test="$show-images = 'true'">
	          <a href="#" class="js-show-folio-image" data-canvasid="{$canvasid}" data-surfaceid="{$surfaceid}" data-msslug="{$break-ms-slug}" data-expressionid="{$expressionid}">
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
	    </span><xsl:text> </xsl:text>
  	</xsl:if>
  </xsl:template>

  <xsl:template match="tei:supplied">
    <span class="lbp-supplied">[<xsl:apply-templates></xsl:apply-templates>]</span>
  </xsl:template>
  <xsl:template match="tei:mentioned">
    <span class="mentioned">'<xsl:apply-templates></xsl:apply-templates>'</span>
  </xsl:template>

  <!-- notes template -->
  <xsl:template match="tei:bibl">
    <xsl:variable name="id">
      <xsl:number count="//tei:bibl" level="any" format="a"/></xsl:variable>
      <xsl:text> </xsl:text>
      <sup>
        <a href="#lbp-footnote{$id}" id="lbp-footnotereference{$id}" name="lbp-footnotereference{$id}" class="footnote">
        [<xsl:value-of select="$id"/>]
        </a>
      </sup>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- app template -->
  <xsl:template match="tei:app">
    <xsl:variable name="id"><xsl:number count="//tei:app" level="any" format="1"/></xsl:variable>
    <span id="lbp-app-lem-{$id}" class="lemma"><xsl:apply-templates select="tei:lem"/>
    <xsl:text> </xsl:text>
    <sup><a href="#lbp-variant{$id}" id="lbp-variantreference{$id}" name="lbp-variantreference{$id}" class="appnote">[<xsl:value-of select="$id"/>]</a></sup>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- clear apparatus editorial notes -->
  <xsl:template match="tei:app/tei:note"></xsl:template>

	<!-- clear citation notes -->
	<xsl:template match="tei:cit/tei:note"></xsl:template>

  <!-- named templates -->

  <!-- header info -->
  <xsl:template name="teiHeaderInfo">
    <div id="lbp-pub-info">
      <h2><span id="sectionTitle" class="sectionTitle"><xsl:value-of select="//tei:titleStmt/tei:title"/></span></h2>
      <h4><xsl:value-of select="$by_phrase"/><xsl:text> </xsl:text><xsl:value-of select="//tei:titleStmt/tei:author"/></h4>
      <div style="font-size: 12px; max-height: 300px; overflow: scroll">
      <xsl:if test="//tei:titleStmt/tei:editor/text() or //tei:titleStmt/tei:editor/@ref">
        <p><xsl:value-of select="$edited_by_phrase"/><xsl:text> </xsl:text>
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

  <xsl:template name="footnotes">
    <ul>
      <xsl:for-each select="//tei:bibl">
      <xsl:variable name="id"><xsl:number count="//tei:bibl" level="any" format="a"/></xsl:variable>
      <li id="lbp-footnote{$id}">
        <a href="#lbp-footnotereference{$id}">
          <xsl:copy-of select="$id"/>
        </a> -- <xsl:apply-templates/>
      </li>
      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="variants">
    <ul class="variantlist">
      <xsl:for-each select="//tei:app">
        <xsl:variable name="id">
          <xsl:number count="//tei:app" level="any" format="1"/>
        </xsl:variable>

        <li id="lbp-variant{$id}">
          <a href="#lbp-variantreference{$id}">
            <xsl:copy-of select="$id"/>
          </a>
          <text> -- </text>

          <xsl:value-of select="tei:lem"/>
            <xsl:text> ] </xsl:text>
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
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>
