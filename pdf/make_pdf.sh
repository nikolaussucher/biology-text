#!/bin/bash
if ! [ $1 ]
then
  echo "Please add an input file"
else {
    texfile=$1
    if ! [ -f $texfile ]
    then
      echo "File does not exist"
    else {
        for i in {1..3}
        do
          xelatex $texfile
        done
        echo "PDF generated!"
      }
      prefix=$(echo $texfile | grep -E '(\w)+(\.tex)' | grep -oE '^(\w)+')

      input=$prefix.pdf
      output=$prefix-low_res.pdf
      gs -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dCompatibilityLevel=1.4 -dOverrideICC -dColorConversionStrategy=/sRGB -dProcessColorModel=/DeviceRGB -dDetectDuplicateImages=true -dPDFSETTINGS=/ebook -sOutputFile=$output $input
      cp $output ../docs/_main.pdf
      echo "Low-res-PDF generated and copied to the docs directory as _main.pdf!"
    fi
  }
fi
