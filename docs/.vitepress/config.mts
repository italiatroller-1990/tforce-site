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
      '/wiki/': [
        {
          text: 'Main & Video games',
          items: [
            { text: 'Overview', link: '/wiki/' },
            { text: 'tForce', link: '/wiki/tforce' },
            { text: 'tForce Dreadbright', link: '/wiki/tforce-dreadbright' },
          ],
        },
      ],

      '/blog/': generateSidebar({
        documentRootPath: '/docs',
        scanStartPath: 'blog',
        resolvePath: '/blog/',
        useTitleFromFileHeading: true,
      }),
    },

    footer: {
      message: 'Licensed under AGPL',
      copyright: 'Copyright © [PRESENT_YEAR] (guess it) Italia Troller',
    },
  },
})