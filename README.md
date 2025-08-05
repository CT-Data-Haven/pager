# :pager: pager custom Quarto format

`pager` is a custom format for Quarto. There are 2 versions: 

* `pager-html` is just a minimal HTML format with a subset of Bootstrap included
* `pager-pdf` takes that HTML document and "prints" it to a PDF using [Weasyprint](https://weasyprint.org/) ^[Other html-to-pdf engines will probably work too, like [pagedjs](https://gitlab.coko.foundation/pagedjs/pagedjs-cli), but Weasyprint, while limited in the CSS it handles, is relatively better maintained.] 

## Installation

To install this format, install the extension at the root of your project.

```bash
quarto use template ct-data-haven/pager
```

This will install the extension and create an example file (template.qmd) that you can use as a starting place for your document.

## Usage

Like any other Quarto format, you can render from the command line

```bash
quarto render document.qmd --to pager-html
quarto render document.qmd --to pager-pdf
```

or using "Render" buttons or commands in any IDE. You can also pass additional arguments to Quarto and Pandoc like with any Quarto document.

## Format options

Because this format was designed for the creation of a fairly complex, printable document, I included a lot of options for tweaking, with default values that closely follow the settings for that project. Options are nested in your document's YAML to make them more organized and easier to refer to ^[Shout out to [kantiles/quarto.report](https://github.com/kantiles/quarto.report) for this idea.]. All values other than Quarto/Pandoc's built-in options are shown here with their default values.

```yaml
heading-font: "Barlow" # name of font to use for headings
is-draft: true # indicates that this document is a draft, for marginalia
color:
  heading: "#3896ee" # heading color
  caption: "#5c6fac" # figure & table caption color
  sidebar: "#edfaffee" # background color for sidebars; note slightly translucent
  aside: "#fdfbedee" # background color for asides, also slightly translucent
  gray: "#4d5f7f" # gray color for miscellaneous markings
logo: # an option to include a logo or other branding
  use-text: true # if true, the logo is stylized text; otherwise an image
  text: "DataHaven" # text to stylize as branding
  font: "GT Pressura Pro Bold" # font to use for branding
  img: null # image of logo to use instead of text; might not work yet
  color: "#4d5f7f" # if using text, color to use
cover:
  cover-page: true # if true, create a separate first page as a cover
  add-logo: true # if true, place the logo at the bottom of first page
  img: 'cover.svg' # image to use for cover background
page: # height & width of pages in inches
  width: 8.5in
  height: 11in
headings:
  uppercase: true # should headings be rendered in uppercase
  title-size: 3.5rem # size of title on first page
  subtitle-size: 2rem # size of subtitle on first page
marginalia: # things that can be put in the headers and footers of chapter pages; see below
  title: top-left # include the document title
  page-number: top-right # include page number
  logo: bottom-left # include logo/branding
  draft: top-center # include note that this is a draft
  draft-include-date: true # if this is a draft, include the date
  chapter: null # include running chapter title
```

Some notes on options:

* Many of these options will fill in CSS for the HTML rendering, so they need to translate to CSS. That includes colors (hex codes are probably safest) and measurements (note that [`rem`](https://developer.mozilla.org/en-US/docs/Web/CSS/length#rem) gives you a size relative to the base font size).
  * The tricky CSS variables are font names and image paths. Images need to be given as absolute paths with a URI scheme attached (for example `file:///home/camille/code/pager/cover.svg`, not just `cover.svg`). The URL to a file online meets these requirements, and it might actually be easier to just load images for GitHub Gists or something. Fonts should be retrievable by your CSS, so either locally accessible (depends on your OS) or available online such as from Google Fonts.
* Headers and footers (`marginalia`) have 3 sections each: left, center, and right. You can select any of those pieces of marginalia you want, or none of them, and place them in whichever section you want. To turn one off, just set it to `false` or `null`. Just note that setting the same area twice will mean one overwrites the other.

## PDF engines

This was designed to work with Weasyprint. Whether you use that or another PDF engine (see the [Quarto reference docs](https://quarto.org/docs/reference/formats/pdf.html#format-options) for possible options), it needs to be accessible for Quarto. [Installation of Weasyprint](https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#installation) is straightforward, but needs to be done first before the PDF version of this format will render.

Weasyprint doesn't implement the full CSS standard, so when you "print" with it, you'll probably get a long string of warnings for rules that are ignored. These are style rules that mostly come from Bootstrap and aren't relevant to printing, so feel free to ignore them.

## Citation

Currently, the attribution section that Quarto generates isn't working with this format, so if you set `citation: true` or nest any metadata into the `citation` object, it will get manually cobbled into an APA-ish suggested citation and put in the frontmatter section of the document (in print, this is the bottom of the page with the table of contents). I'm working on either fixing this or making it its own extension.

## Miscellaneous other files

In addition to the extension and report template, this format also comes with a copy of the APA superscript [CSL](https://www.zotero.org/styles) and a very small bibliography file in CSL JSON format from Zotero (other BibTeX-compatible exports will work). These can serve as starting points, or just working examples.