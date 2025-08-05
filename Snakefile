# minimal workflow to make sure examples are up-to-date with source
from pathlib import Path

srcdir = Path('_extensions/pager/')
scss = srcdir / 'src/scss'
template = srcdir / 'html/'

cores: 1

rule css:
    input:
        srcdir / 'src/package.json',
        srcdir / 'src/scss/pager.scss',
        scss.glob('*.scss'),
        srcdir / 'src/postcss.config.js',
    output:
        css = srcdir / 'pager.css',
    shell:
        'pnpm run --dir {srcdir}/src css'

deps = {
    'css': rules.css.output.css,
    'csl': 'apa-numeric-superscript.csl',
    'bib': 'common-refs.json',
    'qmd': 'template.qmd',
}

rule html:
    input:
        **deps,
        html = list(srcdir.glob('html/*')),
    output:
        html = 'template.html',
    shell:
        'quarto render {input.qmd} --to pager-html'

rule pdf:
    input:
        **deps,
        html = list(srcdir.glob('html/*')),
    output:
        pdf = 'template.pdf',
    shell:
        'quarto render {input.qmd} --to pager-pdf'

rule all:
    default_target: True,
    threads: 1,
    input:
        pdf = rules.pdf.output.pdf,
        html = rules.html.output.html,

rule clean:
    shell:
        '''
        rm {rules.css.output.css} {rules.html.output.html} {rules.pdf.output.pdf}
        '''