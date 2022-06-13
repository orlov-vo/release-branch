          base_tag_name=v$(date +'%Y.%m.%d')
          tag_name=$base_tag_name

          function check_tag_name {
            if [ $(git tag -l "$tag_name") ]; then
              echo "Found existed tag: $tag_name"
              regexp="\A$base_tag_name-fix\.(\d+)\z"
              [[ $tag_name =~ $regexp ]]
              version="$((${BASH_REMATCH[1]:--1} + 1))"
              tag_name="$base_tag_name-fix.$version"
              echo "Created next tag: $tag_name"

              check_tag_name
            fi
          }

          check_tag_name
          
          echo ::set-output name=result::$tag_name
