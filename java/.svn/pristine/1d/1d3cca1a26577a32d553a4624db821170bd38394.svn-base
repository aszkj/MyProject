// 执行调用的函数
var myScroll,myScrollFindBrand, pullDownEl, pullDownOffset, pullUpEl, pullUpOffset, loadableBrand = false;

function findBrandLoaded() {
    pullDownEl = document.getElementById('pullDownBrand');
    pullDownOffset = pullDownEl.offsetHeight;
    pullUpEl = document.getElementById('pullUpBrand');
    pullUpOffset = pullUpEl.offsetHeight;
    showLoadMore(loadableBrand);

    myScrollFindBrand = new iScroll(
        'wrapper1',
        {
            useTransition : false,
            topOffset : pullDownOffset,
            vScrollbar : false,
            // mouseWheel : false, // 是否监听鼠标滚轮事件
            onRefresh : function() {
                if (pullDownEl.className.match('loading')) {
                    pullDownEl.className = '';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                } else if (pullUpEl.className.match('loading')) {
                    pullUpEl.className = '';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载更多...';
                }
            },
            onScrollMove : function() {
                if (this.wrapper) {
                    showLoadMore(loadableBrand);
                    if (this.y > 5 && !pullDownEl.className.match('flip')) {
                        pullDownEl.className = 'flip';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = '松开刷新...';
                        this.minScrollY = 0;
                    } else if (this.y < 5
                        && pullDownEl.className.match('flip')) {
                        pullDownEl.className = '';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                        this.minScrollY = -pullDownOffset;
                    } else if (this.y < (this.maxScrollY - 5)
                        && !pullUpEl.className.match('flip')
                        && loadableBrand) {
                        pullUpEl.className = 'flip';
                        pullUpEl.querySelector('.pullUpLabel').innerHTML = '松开刷新...';
                        this.maxScrollY = this.maxScrollY;
                    } else if (this.y > (this.maxScrollY + 5)
                        && pullUpEl.className.match('flip') && loadableBrand) {
                        pullUpEl.className = '';
                        pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载更多...';
                        this.maxScrollY = pullUpOffset;
                    }
                }
            },
            onScrollEnd : function() {
                if (pullDownEl.className.match('flip')) {
                    pullDownEl.className = 'loading';
                    pullDownEl.querySelector('.pullDownLabel').innerHTML = '加载中...';
                    pullDownActionBrand(); // Execute custom
                } else if (pullUpEl.className.match('flip') && loadableBrand) {
                    pullUpEl.className = 'loading';
                    pullUpEl.querySelector('.pullUpLabel').innerHTML = '加载中...';
                    pullUpActionBrand(); // Execute custom
                }
            }
        });
    setTimeout(function() {
        document.getElementById('wrapper1').style.right = '0';
    }, 800);
    function showLoadMore(flag) {
        pullUpEl.querySelector('.pullUpLabel').style.display = flag ? 'block'
            : 'none';
        pullUpEl.querySelector('.pullUpIcon').style.display = flag ? 'block'
            : 'none';
        pullUpOffset = pullUpEl.offsetHeight;
    }
}

document.addEventListener('touchmove', function(e) {
    e.preventDefault();
}, false);
