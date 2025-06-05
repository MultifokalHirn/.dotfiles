// ~/.finicky.js
const browsers = {
  personal: {
    name: "org.mozilla.firefox",
    openInBackground: false,
  },
  work: {
    name: "com.google.Chrome",
    openInBackground: false,
  },
  selector: {
    name: "com.browserosaurus",
    openInBackground: false,
  },
};

export default {
  defaultBrowser: "Safari",
  rewrite: [
    // {
    //   match: "*.org/*prod-kaeser*",
    //   browser: "Google Chrome",
    //   url: (url) => {
    //     url.host = "xcancel.com";
    //     return url;
    //   },
    // },
  ],
  handlers: [
    {
      match: "https://www.figma.com/file/*",
      browser: "Figma",
    },
    {
      match: "meet.google.com/*",
      browser: "Google Chrome",
    },
    {
      // Open Apple Music links directly in Music.app
      match: ["music.apple.com*", "geo.music.apple.com*"],
      url: {
        protocol: "itmss",
      },
      browser: "Music",
    },
    {
      match: ({ url }) => url.host.includes("bitbucket") && url.pathname.includes("prod-"),
      browser: "Safari",
    },
    {
      match: ({ url }) => url.host.includes("bitbucket") && url.pathname.includes("helden"),
      browser: "Google Chrome",
    },
    // {
    // Open google.com and *.google.com urls in Google Chrome
    //   match: [
    //     "google.com/*", // match google.com urls
    //     "*.google.com*", // also match google.com subdomains
    //   ],
    //   browser: "Google Chrome",
    // },
  ],
};
