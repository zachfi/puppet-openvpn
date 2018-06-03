## 2018-06-02 2.0.2
Testing and module_sync changes.

## 2017-05-24 2.0.0
### Summary

This release removes the older params class pattern in favor of module data, available in newer puppet, making newer puppet a requirement for this module.

### Features
* Remove params class, relocating data to init class and module data
* Add unit tests for primary use cases
* Drop older puppet support, 4.x is now required
* Drop older OS version support, simplifying systemd handling

