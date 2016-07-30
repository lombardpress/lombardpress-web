<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="html"/>
  <!-- params -->  
  

  <!-- this param needs to change if, for example, you want the show xml function to display XML for something other than "critical"; Alternatively, this slug could be found somewhere in the TEI document being processed -->
  <xsl:param name="default-msslug">critical</xsl:param>
  
  <!-- variables-->
  <xsl:variable name="itemid"><xsl:value-of select="/tei:TEI/tei:text/tei:body/tei:div/@xml:id"/></xsl:variable>
  
  <!-- root template -->
  <xsl:template match="/">
    <!-- title/publication info -->
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
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:facsimile">
    
  </xsl:template>
  
  <xsl:template match="tei:p">
    <xsl:variable name="pid"><xsl:value-of select="@xml:id"/></xsl:variable>
    <p id="{@xml:id}"><xsl:apply-templates/></p>
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
    <span id="{@xml:id}" class="lbp-documentary-quote" data-quoterefid="{$quoterefid}">
      <xsl:text/>
      <xsl:apply-templates/>
      <xsl:text/>
    </span>
  </xsl:template>
  
  <!-- ref template -->
  <xsl:template match="tei:ref">
    <xsl:variable name="refid" select="translate(./@ana, '#', '')"/>
    <span id="{@xml:id}" class="lbp-documentary-ref" data-quoterefid="{$refid}">
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
    <!--<span class="lbp-orig" style="display: none;">
      <xsl:apply-templates/>
    </span>
  -->
  
  </xsl:template>
  <xsl:template match="tei:reg">
    <span class="lbp-reg">
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
    <span class="lbp-glyph lbp-pilcrow">&amp;para;</span><xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>
  
  
  


  <!-- clear note desc bib template -->
  <xsl:template match="tei:note | tei:desc | tei:bibl"></xsl:template>
  
  <xsl:template match="tei:cb">
    <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
    <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
    <xsl:variable name="fullcn"><xsl:value-of select="@n"/></xsl:variable>
    <xsl:variable name="length"><xsl:value-of select="string-length($fullcn)-2"/></xsl:variable>
    <xsl:variable name="folionumber"><xsl:value-of select="substring($fullcn,1, $length)"/></xsl:variable>
    <xsl:variable name="side_column"><xsl:value-of select="substring($fullcn, $length+1)"/></xsl:variable>
    <xsl:variable name="just_column"><xsl:value-of select="substring($fullcn, $length+2, 1)"/></xsl:variable>
    <xsl:variable name="justSide"><xsl:value-of select="substring($fullcn, $length+1, 1)"/></xsl:variable>
    <span class="lbp-folionumber">
      <xsl:value-of select="$ms"/>
      <xsl:value-of select="$folionumber"/>
      <xsl:value-of select="$side_column"/>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="tei:pb">
    <xsl:variable name="hashms"><xsl:value-of select="@ed"/></xsl:variable>
    <xsl:variable name="ms"><xsl:value-of select="translate($hashms, '#', '')"/></xsl:variable>
    <xsl:variable name="fullcn"><xsl:value-of select="@n"/></xsl:variable>
    <!-- this variable gets length of Ms abbrev and folio number after substracting side -->
    <xsl:variable name="length"><xsl:value-of select="string-length($fullcn)-1"/></xsl:variable>
    <!-- this variable separates isolates folio number by skipping msAbbrev and then not including side designation -->
    <xsl:variable name="folionumber"><xsl:value-of select="substring($fullcn,1, $length)"/></xsl:variable>
    <!-- this desgination gets side by skipping lenghth of msAbbrev and folio number and then getting the first character that occurs -->
    <xsl:variable name="justSide"><xsl:value-of select="substring($fullcn, $length+1, 1)"/></xsl:variable>
    <span class="lbp-folionumber">
      <xsl:value-of select="$ms"/>
      <xsl:value-of select="$folionumber"/>
      <xsl:value-of select="$justSide"/>
    </span>
    <xsl:text> </xsl:text>
  </xsl:template>
  
      
  <!-- named templates -->
  
  <!-- header info -->
  
  
  
  
  

</xsl:stylesheet>
