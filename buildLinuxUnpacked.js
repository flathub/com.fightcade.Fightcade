const builder = require('electron-builder')
const packageFile = require('./../package.json')
const version = packageFile.version
const Platform = builder.Platform
const Arch = builder.Arch

require('./createPackage.js')('linux', {arch: Arch.x64}).then(function (path) {
  const options = {
    linux: {
      target: ['dir']
    },
    directories: {
      output: 'dist/app/'
    },
    publish: null
  }

  builder.build({
    prepackaged: path,
    targets: Platform.LINUX.createTarget(['dir'], Arch.x64),
    config: options
  })
})
