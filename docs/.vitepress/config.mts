import { defineConfig } from 'vitepress'

export default defineConfig({
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Wiki', link: '/wiki/' },
      { text: 'Git org', link: 'https://git.italiatroller.dpdns.org/tForce' },
      { text: 'Devlog', link: '/devlog/' },
    ],

    sidebar: {
      '/wiki/': [
        {
          text: 'Main & Video games',
          items: [
            { text: 'Overview', link: '/wiki/' },
            { text: 'tForce', link: '/wiki/tforce' },
            { text: 'tForce Dreadbright', link: '/wiki/tforce-dreadbright' },
          ]
        },
      ]
    }
  }
})

