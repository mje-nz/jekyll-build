## Jekyll Build Action
A GitHub Action for building a Jekyll site.


### Why?
GitHub Pages supports Jekyll out of the box, but very few plugins are supported.
If you are using anything but the most basic Jekyll setup, you're likely going to need another way to get your site into GitHub Pages.


### Prior Work
This is based on [Josh Larsen's Jekyll 4 Deploy action](https://github.com/joshlarsen/jekyll4-deploy-gh-pages).


### Setup
Create a `main.yml` file in `.github/workflows`.

```yaml
name: Jekyll Build

on:
  push:
    branches:
      - master

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - name: GitHub Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false  # required for JamesIves/github-pages-deploy-action

      - name: Bundler Cache
        uses: actions/cache@v2
        with:
          path: vendor/bundle
          key: ${{ runner.os }}-gems-${{ hashFiles('**/Gemfile.lock') }}

      - name: Build Jekyll site
        uses: mje-nz/jekyll-build@master

      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@3.5.7
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BRANCH: gh-pages
          FOLDER: _site

```

Optionally, you can pass extra arguments to `jekyll build`:

```
      - name: Build Jekyll site
        uses: mje-nz/jekyll-build@master
        with:
          JEKYLL_ARGS: --config=_config_drafts.yml
```

### Caching
Bundler caching on a mostly vanilla Jekyll site reduces deploy time from 3-4 minutes down to less than 1 minute.
The cached build step is reduced from ~3 minutes to ~12 seconds.

![build without cache](img/build-no-cache.png)

![build with cache](img/build-with-cache.png)



### Security
If you don't trust running third party actions in your repo, you can always fork this one and substitute `mje-nz/jekyll-build@master` with your repo name/branch in your workflow `.yml`.


### Issues
Feel free to file an issue if you have a bug fix or an improvement.
