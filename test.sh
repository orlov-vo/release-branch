          base_tag_name=v$(date +'%Y.%m.%d')
          tag_name=$base_tag_name

          function check_tag_name {
            if [ $(git tag -l "$tag_name") ]; then
              regexp="^$base_tag_name-fix\.([0-9]+)$"
              [[ $tag_name =~ $regexp ]] || true
              version="$((${BASH_REMATCH[1]:--1} + 1))"
              tag_name="$base_tag_name-fix.$version"

              check_tag_name
            fi
          }

          check_tag_name
          
          echo ::set-output name=result::$tag_name
