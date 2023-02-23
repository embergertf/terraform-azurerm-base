# Changelog
<!-- markdownlint-disable MD024 -->

[[_TOC_]]

All notable changes to this module are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- ## [Unreleased]
### Added
### Changed
### Removed -->

## [3.0.0] - 2023-02-23 - Improved date tag

### Added

- variable `UTC_to_TZ` and `TZ_suffix` with defaults to EST

### Changed

- `Created_on` tag now displays in Timezone instead of UTC

## [2.0.1] - 2023-02-23 - Bug fixed Location name and display name

## [2.0.0] - 2023-02-23 - Added Location display name

### Added

- output `location_display_name` that displays a set display name of the location

### Changed

- `location` outputs now the `name` field of the location

## [1.2.0] - 2023-02-22 - Replaces 3 defaults by `null`

### Changed

- Defaults values for `subsc_code`, `env` and `owner` replaced by `null`

## [1.1.0] - 2023-02-22 - Added region codes CAC & CAE

### Changed

- Added CAC & CAE Azure regions' codes

## [1.0.0] - 2022-11-11 - Initial Handover

### Added

- Added Base module
