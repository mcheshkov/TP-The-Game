#!/bin/sh
mxmlc --static-link-runtime-shared-libraries=true -debug=false -optimize=true -o bin/TheGame.swf TheGame.as
