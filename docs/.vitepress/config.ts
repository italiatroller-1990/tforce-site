import { defineConfig } from 'vitepress'
import { generateSidebar } from 'vitepress-sidebar'

export default defineConfig({
  title: 'tForce',
  description: 'A game series as learning projects.',

  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Wiki', link: '/wiki/' },
      { text: 'Git org', link: 'https://git.italiatroller.dpdns.org/tForce' },
      { text: 'Blog', link: '/blog/' },
    ],

    sidebar: {
      '/wiki/': generateSidebar({
        documentRootPath: 'docs',
        useTitleFromFrontmatter: true,
        frontmatterTitleFieldName: 'title',
        useFolderLinkFromIndexFile: true,
        useFolderTitleFromIndexFile: true,
        excludeByGlobPattern: ['blog', '**/wiki/index.md'],
        sortMenusByName: true,
      }),
    },

    footer: {
      message: 'Licensed under AGPL',
      copyright: 'Copyright © [PRESENT_YEAR] (guess it) Italia Troller',
    },
  },
})
