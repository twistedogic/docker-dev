PRODUCT_KEY="${PRODUCT_KEY:-XXXXX}"
sed -i "s/<key>/${PRODUCT_KEY}/g" ~/.graphlab/config
ipython notebook --no-browser --ip 0.0.0.0 --port 8888
