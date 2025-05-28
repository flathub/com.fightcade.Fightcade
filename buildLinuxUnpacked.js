
/**
 * Modified from buildAppImage.js in the min browser GitHub repository:
 * https://github.com/minbrowser/min/blob/master/scripts/buildAppImage.js
 *
 * This script builds a prepackaged Electron application for Linux using electron-builder.
 * It first creates a package for the 'linux' platform with x64 architecture,
 * then invokes electron-builder to generate a directory target in the specified output directory.
 *
 * @module buildLinuxUnpacked
 * @requires electron-builder
 * @requires ./../package.json
 * @requires ./createPackage.js
 *
 * @throws Will log and exit the process if package creation fails.
 */
const builder = require('electron-builder')
const packageFile = require('./../package.json')
const version = packageFile.version
const Platform = builder.Platform
const Arch = builder.Arch

require('./createPackage.js')('linux', { arch: Arch.x64 })
  .then(function (path) {
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
  .catch(function (error) {
    console.error('Error creating package:', error)
    process.exit(1) // Exit the process with an error code
  })
