#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Darwin subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step9...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Darwin\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� uxe �}xŕ`͌�,�lp���?�c��g$�������?��8��4�F3b~�Q�f5fu���1�YY�]/�%J��3�	V.ܢ$w'a/J�k�`%aѽ�z=�=�%���z��_�z�^��zU���Un�V��v����Nb�ɱ���c�Q[gw8�k `w���D�;ۆQ��#���:l�G�{=��@�����G
�;���]�H0����V����V������Y]K$��2H�����������p-��B�]�������4m��|���l��C�����]�]9�22 ]�W)&+J��I�eꓮ��ږ��"��"ҧ'%�����;p-��h�A�+1�S:��no(�������u���}�������Q"��L}'u�A_(Jk8�:����u\_���C�n��#:ڨo�z�O�і��Ew�m�/�̡�����B��~w��ٴa�e�M�wrm������L��Թ]^}W��}=K��]jJ��їaW_n��:+�ߣ��w��Jw$�Wߨ���E��'�j�D<zڨo�u�h��ʀ���u��-��Z_&2�ਊO;��g���v�+T�����Of���A���g��P��CGV�gԹ/��h�y��B�s�/"ܷ+�Z�V�}-����ې!�ݴ��o�o��o��CM��z�՘��r[*�3�̟"��4 ��z�|�Z��`>q��b�5e\�W_�ʱ
��0����my����ሷk�����
�g�o���}�D�  @�  @�  @�  �c�ݱ���o4��?�d�w��&�{'��CO@�;.'�q�;��[�Q�~)$�N�խ=�#�<N��P})�J��"'�MȈ���:|&�v]<���y��C�`��S�&(�6��I��`.-s�)��܇z�ܱ�cj+���#{I��Bޱ.��'h����8K���i�J�T5R��F����eQZ��V6�o�fW�=�捨�%������ aF�2'.��N���m�1�Ef�� ?� 8q�w���{O�ɣ�ع����.?�z�}�Grc�@e���1Y�LI��sY�!1��c�S_�t���ޓZ��t��ɩ�I�V�=i]N|��ɸ��Ku�N/����VD�z<����&U�=@&Զ��\�YI�d9�	����ʿ�A�D�%����f:�����N��zv@~�%<(?{�d=H?����z�eQoA���ǌUQ���+���+��OJփ�5?�@��䡉2�R2xpw�m�i��n�~P�G��(ӿ5.�4�톜�c�G!��&��Q�I�왚�╋�gК�*$��@O�r��ܺ.����l��[u6�_�X�����LϘ�\��P��bԥ�l1��}/�N�{2��_�B��δj���kT,fcA�עw�l��>\��E���� ��d}&���A��l�n��N�{�9�5&�ȯ��{��zpa�''^`."�f�r�55������t�õVNX^²mK�&9���<«H���e
&և�x�l�w�ߢ�����Ky�$��c3i-��;��c�����W���c/tCS��Q5q���2OQ����k^�G��&}��k��g��O�l��D�'�1�!Z��k�cl���?�vZ�8��(��z�uְ�y�d�5�QS�&�@�Dl��Дf�$�'�SU�̕�	����2#7�_���n���j����,ҍ׋���%���P��	*k=���� V8�G���h�V��w�>��A�=�軴z��j]q�ځ|�j�����鏻�3��O2NƼ��t���/.z��1-ǀ���|�-�v�-FY�C��WM|��+S���־�{8+رl�縬고~{�=����C06�WW�.:�2����n���y�C��U/-�2�3��朤ZϋO��qo��1HPՋ�)���u���?�"���IVڗs}�ퟋ<���������r�s��՛��"��Sh��O�=wЊ>&�������%�����k�rW��_Hx\�ʤ�Oյ=�_�m�����|����Oj��Bk+�+�D�G�SSY�Z��A�U��'��A,:	q�Zy2��2��T�?��T��>�Y`��6���x�R��x�}5@h<tJ!T��4p;��=�_|�c�L��������_W_��a��_/�5]������nTj=��TSCj��;��%U��:���T��K6����?j5]��/*��v���iS� �V>�{LҝĤ� գi����[��U��C
(�k�F�4k2����������OX��N�@�������Y�O�l������Rm�
���L�@MZG݇��j�Q4�
9%�Fۣ���r롯qc�f��F{j�Q��O����N���lOE`��n���S�ƇYb�u�<5oUij��T�/�vbWQ�9i����D�G)��K���Z��_��\��w�uy_�|�o�4]|�+�h����dqF�����=I�񻜵�F�x��"o�x��o������7ə�盦��#?��?��CL�ٍzR%L]�o#!SW������v�"������~��`�v��b���}���3�?��av?��e�!v�kv���v#���C�7xذs�ߙa��<�������'^�O�i'~L���O������8N�>C���Ot>�x�>��>ѧ�A�ģ��V��}z�>�O�^�O�F��MV�>]O�������6��7���>�@�n�O?�O��'Z��j��M��ƮS���U��U��L^7}����cӊ��lZ����f�w͟&�K�?XH��$䄥�g�K�u��tK���l&GͿ�t-4�(�M��\%���+/T��k��K��¾`@"��ûF"R ����]�^)|g��J�`0"ہ�K �"��xZ�pJ�ϰ�v_�M�$_��y��>�?���`Ww4�t��*�,-^�� ����]G�L�9���S�/"�o(/'��ſ˥���\��5���#9x-gR��ӿ�ZIH%,;cW��jB� v��	8��i:���u��C+I�ʻ�4��LLݰ`�w�Ĝ�������a>�*A6c���җ��b i����_�  @�  @�  @�  @�  @�  @�  @� 0�0���5����j8�#��c�oD���w"!��"���h�=�#A�����!�2����7���܂��C?Z�ԑ�����A�����s �'*����&�e�|�����K��/~���RM�zt�����\�mg @�  @�  @�  @�  @�  @�  @�  �,�����H�'���;#5��mF#2�9Du�u�����ͭr��M&}e��t��(��P8��}���>;<�ն�ߦ�#���h��S�p�vzBJ$��E ���ީ���}>rsx�`�o�]�G
�8��@G�Sn��j���U��hD�Ҟֈ7���wF��V����J��4�����*�p$��tmޥ�+���^iڲ�V�"}n}!��@�v�H�L���<s-����B�2���s@���]��o8���������q�����1�*�Vo�`WXG�p�A��+P����@F�$l�;���������=~Zp$b�r*����.��a�Tv�R���+����uTe�D�N�Ǔ�Mg����w���yvg����ot�;v�(TI�hM�y��a��f�UV��g2�T�H�Mޱ�f�U�M��Zq8h40S�_T���_D���j�>�7�
���Ν�������۩�1.�3�sR�/��xY�a����x�o�/��孝�3��xi�Zz��� &@¦ �B��E!uy|��3��i�{��b��T�=��hītz=t���m;���,dh;!fn4��Q��t�G�Ԓ�-�h���	�\�ȗ�gi��93'3[�7K��z�	��_[>0g-^�Yp}z�b)�r��m����>��,�6o���;��c�7,��>h������̸>m���&{�"ICEv�[�WIv�&{sU�$UU5�%�T%U5I@��(KJ�%�����T�`1!��:x�?"ݍ�'J8=�����'M}d�"?i���RNK�8}-�.���F��H�!��r�d5��S��UH_����"݌�W�D�7H'�.Y��"�i��B���r��o#=���
ԇ�#HW98=��ii�+9݄t3�CH�1�KbyH+HK��H��ް�#B��G��CZEz鋭X�k�v�PA�H��&��I��ZN��&�5��;����4�W���_CN�%�F��������O}�F�7��X�џH�џ�Fjn0��p�џ����j4�SS�џ�����h���F�?7�)�h���5Fr�1�S��?�1����?%��i|�џ�k���Zk���F�[k�'r�џ����i[�E���瀭G��:Nߌ��V�� ��N�cH� �8�H���gc}�������H'�����yj~��s�!����m���і�8-!}�ڹh���Ul�`�n��KWr�YJ���h��Lk��1�M���|��nˠ��A��A_m�ȟA?�A�2�^Rd�7gзe��A�Ƞ�AW�k2�utS�ɠ�*6���W3��g��=p���J�./\.��:���u;\��?��pu��Y��+D�^��(\w�v���\�>�r)H���Ѣ��`eBg�`�W3{Ap�_�ϫ�yx-�(����Jz_���`��	
�!��w��V`^���M����q�?�}��v����g����]���_�z�_h㟵�ϱ�����~�m��޼΢�n�n3�<��ѱyS@NͲ[f�v��Z�~��������R����6b-�v�-�,�&U'��w6�t�Lu���2s��],e����Pd�YƵ�#��Df#�"y��m����<gb��]o��e�-��=Oe����=��J�_I�p�
��k�dL\u)w�������@�ypFm��25�m��'����S�3�zh�`Ww�{���}�ͳ�������u
�4O���y�=Q�-�J��!�� �z�.�&+�%�gj����`�.O�-oF��Fg�����ڽ!���X�I}�W�U9���v͹�[}vyk��ul>kgh����>(v�T�!3dɜX� TǷ���+���TsN����� k#A���F�ݼd�v)Z�1��怬C*�A������nV*!�+�`�c>���R}�i����wC���Fb]�/��:�����萵XoM��ÞJB8�0����v�w�8��B^=Å|�u�.��[4�f�`N�o���ؚޕ�^I�t[��F���O	�Й2Ҹ��umKń�޸����n:Q��Ӟ�R��Ґ�RS��T[�-�̖r@eX��s�^���h�Gۼ��fv����Nb�ɱ���c�Q[gw8�k `w������l�A�:��������^On9ko/����N@��m�H��K�U��Z����6�;���ں��:G]���	@$��Z��������#!(./x���nXC$�KZ��`fL��&�
�{V�-�-�SW@��@����>Cؿ1h�u��0��w:����Vp1�?X�Z�tz�V��ѐ�M
v�1�	�I�E �K�Ֆ4)�����7��|"��7mW�m�������� `��������Q�E�gw֋�� ��pÿ<M0[�f��.��H���G�\�	�v^W~�cu�]J���X���P�D�H�l�K�٠I6�+ʪ��n�$� ��i�.y�[���&��*�-�!G��������S�����gU0U�W��懥��,��Q׈	��\��7���i��.�˂��D�=�t>E�%�ٕ��b�>j�3~<R�R����6OkD��_㕭��|)O��-����(f���x;������se�e�t�(T�OBRPMe�VV%W�
��f�<`�:!?i�h��:S�펽�����by�k�<��dw��U{O��.Ne�%�w� ��*SUei� H]i�54�A�/�aQ��K�<�+���+��*�n)��/��Y ��wB)[}-!Oh�|�����5��5Y���.���f=��[��_�f>�(�	q7�G��8��7�����1��>�)>O����Z�o���|�k������z���;�1p�7L�M�|7�VX#�\��2��.�]f7�X��Gm����7��#�r�E=X2n5��E�*JGk��W�L}*��k	U�G�>����޴a׆4ݼ��=H�Te�d���~J�F�FP��*c�L[����"���9^����1���*��������y\��R�wgw5A� ���.2�]W�U�z��3���4�JZoI�[W���2P,�p�q4$KRRŧ��1��OX��N�@�<<���9���>T���x.v�g����9�nu*�dU�(+��M��}��z�k��Y���.��Xg�6x���>w����锹p��J޺R>O�{_M��je�<�-e롺�d��\��˯�'L1���!�Ă�@bX�ޓ��}���ܱ�Iw,�t�A &�N�z��x/$FUw�{Z$,�=9�������S��<N�.'>��d��Rwܥ�M���kVӲ��S�a�g3m�����du�"c�����P�i�e�7#R�,�A��c&�Aڱ{MT1�2��B�{�hc���	ަ�WS���ky,�D1yh�,�d��>FǷ��Q ����A��(ӿ5.�4�톜�c�G!��&��Q��=Й�rq�ZP��*w6�����&f�'ne�N��ܱmc1�剥	��=c���h�����>��E�){O[b�ٙV�3�X@�km_e]~�M��N�O�~��o=H.7Y�I�=��1��M���Cԉw��=�����wo�X.L�����E�ӬW���N�*� oĽVNX^²mK�&9���<��3��2���u��lL�ws�k�a끥<s�����������1ft�z|�+�ڇݱ����?�3��<EK�^�8�դ��u�<b=��Q�)y�.���d0&?D���@
��0�B����{�5�x�&�I�\�w"G"��~(O�$�h�V��Er�_P~R�g���ʌ�,���FNQ��ÃڠI�׋���%�5p��Z�� 60�5���'��ڤ�����@��$�A�eO,�.�^<�n�ځ|���Y��2cW���&cކЇ�\:��������c@~K� ���nq����ǹ�P�hkYܽ�����s\V�Y�x#۞X�i�!��v�k3��L#���?o{���w��hsNjALh�M9c��f���/�r����N���d����u�A_fyZ{�fM��tm>R'f��N�oh�X���M��Ib��t�����U\ k�)���2�eF�Q������1�����#�+㭤�����p����\��� �����'s�/#�Ef�?��T��>�Y`]��ZD#���o������B��ʧ���5��xL~5%@C�|��G���Ez~���;��6@���oO55��ܼ��]R�aJ%)H���rב/Sx���S�9L+.\��i�柛M�5��,��`!q,�',�?��^�\�{�;5eZL��N숹��fr��[Κzl��hE�l2��*ɕ�\y�B�_K
@r���y���{�����g���ד�_��g�놲�t>|���ѥ���?U�z��S=:T��be.M����>|�"A�����a�+y�V���K�<��W"a�?���}�`�Dh�`i��u�z�ލ)hhS�Ô-y���9�7�{�*|Ypa��v�/��oB�9f����=B7� pY��C�_���@~G>��=���C�%y���?'����Oï����߅�y���ߐ��@��y�I����oZ��<�f�����gp��4���7�����%T�*�	����e����/����O�?9M~��
`G��W�㯩���n����A��_�3�돌��6�}.��.�g�����/�ß�w��7��>-g��T���<�&���\r��n��¿�R�G�A�-���[\��r�U�(�-- W	u��]V@��T�[\@�s:}���U�p�
�}�$��������;��� gG�k
�]nN�+$���6����97ʭ( �8�5�܆r/�\�]]@���C��X��PnQ�kAn����3Jޙ�O���+$��%]�B�
r�3�GQQ�?n* w�u�ܪr����-/ ���+�=��W�]^��+T�w�y=3�wQq��
��T<������и|�8]�B��w����( �ȝF�K�U1>�qT��r�瑻��le)}�F�U��r�T��oR�Sm��Qy�3��l?���~�_��������?);�_�i��8_�j�O���}�d���N���_c%�-�f|`+�+Xk��k]����=�����m3`;�++�Zo�U9��m�,g������v�O�|����=��X��^_�b�W���v����a�]϶�y�?	�|�K��U����0�m�������}�d����B6sۓ����-��_����dk3������h�߀?8�
�s%������_�b\�(�*l�m�F|G1O�S�~��m(f���E<�+�P� ˀ�����w��׀7~�ڞH����)m�X��q���~K�9�I��,�7l�
�E�6�ߏma�=�m;�.��[#����f+\x��d��q��K&�ٮ��n[gb�����u��0��
m��XyK���rL/��	;�l�m����#�v�+����F�Q���N4?���W0�6̷q3?_�ąXB���շ��o���ۘ>�Ͽ*I B܇�����.���1݅XBL�[P�!�}���K�	�q3�G<��1~�X�B,!&��M���>�͈]�%�xhW�$����\���ԇx�a�D�>LoF�B,!&��(a����s�p�\��j��I�s�����i�	������C��1ˏ��������QD�a�ϒ~Or?�����a��T�9��� g�#���Ũ_���P�����W�HmFym�}<�Q{��O�����>H_��j���s���k�h�|5��~�g�_��ߋ����!���Oc�h����>m}#��~��{X�����E�Y�k�g�f?������=؞ھw���B�OlϷ������������O=Z��������#exn!�c�e9����P1�K��������݌�����Z����?�G�)J�SRj��R����-F���+����eF���H_Zn�Rd����F������xQO�J��)��?2���A{���=��\�I��Ȫ��gL����wv���4���/��ITO~:����y/s<�C�i���|@W��v��<�u6���9��O��i�x��G����NK+t<Y�C	gv��w�����<��e�]�?���p`V�[��O#�:6n�������3�ۉ3==��Fs8Ki~���O� ��6/������3=���s����Ŭco�ک��c���=m����<ǣv�����>�6�����r�����\' @����?���h 8 