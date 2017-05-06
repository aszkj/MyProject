package com.yldbkd.www.buyer.android.fragment;

import android.animation.Animator;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.AnimationDrawable;
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Vibrator;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewPropertyAnimator;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.AccountActivity;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.adapter.CouponResultAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.RedEnvelopeInfo;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.bean.UserRedEnvelopeInfo;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.DefaultItemDecoration;
import com.yldbkd.www.library.android.anim.RainView;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CountDown;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import static android.media.AudioManager.STREAM_SYSTEM;

/**
 * 抢红包游戏页面
 * <p>
 * Created by linghuxj on 2016/10/9.
 */

public class RedEnvelopFragment extends BaseFragment {

    private static final long COUNTDOWN_TIME = 5 * 1000L;
    private static final long COUNTDOWN_INTERVAL = 1000L;

    private RedEnvelopeInfo redEnvelopeInfo;

    private View backView;

    private RelativeLayout bgLayout;
    private TextView residueTimeView;
    private ImageView gradImageView;
    private TextView gradCountView;
    private RainView rainView;
    private RelativeLayout countdownLayout;
    private TextView countdownView;

    private CountDown residueCountDown;
    private CountDown timeCountDown;

    private RelativeLayout resultLayout;
    private LinearLayout resutlBgLayout;
    private Button continueBtn;
    private Button findBtn;

    private int[] endLocation = new int[2];

    private boolean isGameAct = false;
    private boolean pauseStatus = false;

    private int gradCount;
    private RecyclerView redEnvelopListView;
    private CouponResultAdapter couponAdapter;
    private List<Ticket> ticketList;
    private View.OnClickListener continueListener;

    private Random random = new Random();

    private HttpBack<UserRedEnvelopeInfo> userRedEnvelopInfoHttpBack;
    private HttpBack<UserRedEnvelopeInfo> startRedEnvelopInfoHttpBack;

    private MediaPlayer bgPlayer;
    private SoundPool soundPool;
    private Map<String, Integer> soundMap = new HashMap<>();
    private boolean loadedSound = false;
    private static final String ENVELOP_CLICK_SOUND = "clickSound";
    private static final String ENVELOP_CD_SOUND = "countDownSound";

    private Vibrator vibrator;

    @Override
    public void initBundle() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP) {
            soundPool = new SoundPool.Builder().setMaxStreams(2).build();
        } else {
            soundPool = new SoundPool(2, STREAM_SYSTEM, 0);
        }
        soundMap.put(ENVELOP_CLICK_SOUND, soundPool.load(getActivity(), R.raw.red_envelop_click, 1));
        soundMap.put(ENVELOP_CD_SOUND, soundPool.load(getActivity(), R.raw.countdown, 1));
        soundPool.setOnLoadCompleteListener(new SoundPool.OnLoadCompleteListener() {
            @Override
            public void onLoadComplete(SoundPool soundPool, int sampleId, int status) {
                loadedSound = true;
            }
        });
        vibrator = (Vibrator) getActivity().getSystemService(Context.VIBRATOR_SERVICE);

        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        redEnvelopeInfo = (RedEnvelopeInfo) bundle.getSerializable(Constants.BundleName.RED_ENVELOP_INFO);
    }

    @Override
    public void initHttpBack() {
        userRedEnvelopInfoHttpBack = new HttpBack<UserRedEnvelopeInfo>() {
            @Override
            public void onSuccess(UserRedEnvelopeInfo userRedEnvelopeInfo) {
                boolean hasActivity = userRedEnvelopeInfo != null && userRedEnvelopeInfo.getRedEnvelopeActivityInfo() != null;
                setContinueState(hasActivity && userRedEnvelopeInfo.getResidueTimes() > 0);
            }
        };
        startRedEnvelopInfoHttpBack = new HttpBack<UserRedEnvelopeInfo>() {
            @Override
            public void onSuccess(UserRedEnvelopeInfo userRedEnvelopeInfo) {
                boolean hasActivity = userRedEnvelopeInfo != null && userRedEnvelopeInfo.getRedEnvelopeActivityInfo() != null
                        && userRedEnvelopeInfo.getResidueTimes() > 0;
                setContinueState(hasActivity);
                if (hasActivity) {
                    redEnvelopeInfo = userRedEnvelopeInfo.getRedEnvelopeActivityInfo();
                    init();
                }
            }
        };
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_red_envelop;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(R.string.grad_red_envelop);

        bgLayout = (RelativeLayout) view.findViewById(R.id.rl_background);
        residueTimeView = (TextView) view.findViewById(R.id.tv_residue_time);
        gradImageView = (ImageView) view.findViewById(R.id.iv_grad_count);
        gradCountView = (TextView) view.findViewById(R.id.tv_grad_count);
        rainView = (RainView) view.findViewById(R.id.rain_view);
        countdownLayout = (RelativeLayout) view.findViewById(R.id.rl_countdown);
        countdownView = (TextView) view.findViewById(R.id.tv_countdown);

        resultLayout = (RelativeLayout) view.findViewById(R.id.rl_result);
        resutlBgLayout = (LinearLayout) view.findViewById(R.id.ll_result_bg);
        continueBtn = (Button) view.findViewById(R.id.btn_continue);
        findBtn = (Button) view.findViewById(R.id.btn_find);
        redEnvelopListView = (RecyclerView) view.findViewById(R.id.rv_red_envelop);

        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        redEnvelopListView.setLayoutManager(layoutManager);
        redEnvelopListView.addItemDecoration(DefaultItemDecoration.getItemDecoration(getActivity(),
                R.color.transparent, R.dimen.red_envelop_result_gap, false));

        init();
    }

    private void init() {
        resultLayout.setVisibility(View.GONE);
        bgLayout.setVisibility(View.VISIBLE);

        rainView.setHandler(new RainHandler(this));

        ticketList = new ArrayList<>();
        couponAdapter = new CouponResultAdapter(getActivity(), ticketList);
        redEnvelopListView.setAdapter(couponAdapter);

        residueTimeView.setText(String.format(getString(R.string.game_residue_time),
                String.valueOf(redEnvelopeInfo.getMaxTimePerTimes())));
        gradCount = 0;
        gradCountView.setText(String.format(getString(R.string.game_grad_count), String.valueOf(gradCount)));

        countdownView.setText(String.valueOf((int) COUNTDOWN_TIME / 1000));

        if (timeCountDown != null) {
            timeCountDown.cancel();
        }
        timeCountDown = new CountDown(COUNTDOWN_TIME, COUNTDOWN_INTERVAL, new CountDownHandler(this));
        if (residueCountDown != null) {
            residueCountDown.cancel();
        }
        residueCountDown = new CountDown(redEnvelopeInfo.getMaxTimePerTimes() * 1000L, COUNTDOWN_INTERVAL,
                new ResidueHandler(this));
        timeCountDown.start();
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        findBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(getActivity(), AccountActivity.class);
                    startActivity(intent);
                } else {
                    intent = new Intent(getActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
                AppManager.getAppManager().finishActivity(getActivity());
            }
        });
        continueListener = new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                continueBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
                continueBtn.setBackgroundResource(R.drawable.grad_red_envelop_unchecked);
                continueBtn.setOnClickListener(null);
                startRequest();
            }
        };
    }

    @Override
    public void onResume() {
        super.onResume();
        pauseStatus = false;
        resumeBgSound();
    }

    @Override
    public void onPause() {
        super.onPause();
        pauseStatus = true;
        pauseBgSound();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        rainView.setEnd(true);
        if (timeCountDown != null) {
            timeCountDown.cancel();
        }
        if (residueCountDown != null) {
            residueCountDown.cancel();
        }
        if (soundPool != null) {
            soundPool.release();
        }
        stopBgSound();
    }

    private void setContinueState(boolean hasResidueCount) {
        if (continueBtn == null || getActivity() == null) {
            return;
        }
        continueBtn.setBackgroundResource(hasResidueCount ? R.drawable.grad_orange_envelop_continue_selector
                : R.drawable.grad_red_envelop_unchecked);
        continueBtn.setTextColor(ContextCompat.getColor(getActivity(), hasResidueCount ? R.color.primaryText
                : R.color.secondaryText));
        continueBtn.setText(getString(hasResidueCount ? R.string.red_envelop_result_continue : R.string.red_envelop_result_break));
        continueBtn.setOnClickListener(hasResidueCount ? continueListener : null);
    }

    private void setCountdown(long time) {
        if (countdownLayout.getVisibility() == View.GONE) {
            countdownLayout.setVisibility(View.VISIBLE);
        }
        playSound(ENVELOP_CD_SOUND);
        int second = (int) (time / 1000);
        countdownView.setText(String.valueOf(second));
    }

    private void gameBegin() {
        countdownLayout.setVisibility(View.GONE);
        rainView.setEnd(false);
        rainView.initView();
        residueCountDown.start();
        isGameAct = true;
        startBgSound();
        gradImageView.getLocationInWindow(endLocation);
    }

    private void setResidueTime(long time) {
        int second = (int) (time / 1000);
        residueTimeView.setText(String.format(getString(R.string.game_residue_time), String.valueOf(second)));
    }

    private void rainClick(View view) {
        int probability = random.nextInt(100);
        if (probability < redEnvelopeInfo.getInterfaceInvokedProbability()) {
            gradRequest(view);
        } else {
            showEmptyView(view);
        }
        playSound(ENVELOP_CLICK_SOUND);
    }

    private void gradRedEnvelop(View view) {
        vibrator();
        view.animate().cancel();
        view.setOnClickListener(null);
        final int index = (int) view.getTag();
        ViewPropertyAnimator animator = view.animate().x(endLocation[0]).y(endLocation[1]).rotation(720f)
                .scaleX(0.4f).scaleY(0.4f).alpha(0.3f);
        animator.setDuration(750L);
        animator.setListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                gradCount++;
                gradCountView.setText(String.format(getString(R.string.game_grad_count), String.valueOf(gradCount)));
                rainView.remove(index);
            }

            @Override
            public void onAnimationCancel(Animator animation) {
            }

            @Override
            public void onAnimationRepeat(Animator animation) {
            }
        });
        animator.start();
    }

    private void gameEnd() {
        rainView.setEnd(true);
        residueTimeView.setText(getString(R.string.game_over));
        isGameAct = false;
    }

    private void gameOver() {
        stopBgSound();
        request();
        couponAdapter.notifyDataSetChanged();
        if (ticketList.size() > 0) {
            resutlBgLayout.setBackgroundResource(R.mipmap.red_envelop_result_bg);
        } else {
            resutlBgLayout.setBackgroundResource(R.mipmap.red_envelop_result_none_bg);
        }
        bgLayout.setVisibility(View.GONE);
        resultLayout.setVisibility(View.VISIBLE);
    }

    private void showEmptyView(View view) {
        view.setVisibility(View.GONE);
        int x = (int) view.getX();
        int y = (int) view.getY();
        RelativeLayout.LayoutParams layoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,
                ViewGroup.LayoutParams.WRAP_CONTENT);
        layoutParams.leftMargin = x;
        layoutParams.topMargin = y;
        final ImageView imageView = new ImageView(getActivity());
        imageView.setBackgroundResource(R.drawable.red_envelop_empty);
        AnimationDrawable animation = (AnimationDrawable) imageView.getBackground();
        animation.start();
        bgLayout.addView(imageView, layoutParams);
        int count = 0;
        for (int i = 0; i < animation.getNumberOfFrames(); i++) {
            count += animation.getDuration(i);
        }
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                bgLayout.removeView(imageView);
            }
        }, count);
    }

    private void playSound(String key) {
        if (loadedSound && !pauseStatus) {
            soundPool.play(soundMap.get(key), 0.08f, 0.08f, 0, 0, 1.0f);
        }
    }

    private void startBgSound() {
        try {
            if (pauseStatus) {
                return;
            }
            bgPlayer = MediaPlayer.create(getActivity(), R.raw.red_envelop_bg);
            bgPlayer.setLooping(true);
            bgPlayer.start();
        } catch (IllegalStateException e) {
            Logger.e("播放器发生异常情况");
        }
    }

    private void pauseBgSound() {
        try {
            if (bgPlayer != null && bgPlayer.isPlaying()) {
                bgPlayer.pause();
            }
        } catch (IllegalStateException e) {
            Logger.e("播放器发生异常情况");
        }
    }

    private void resumeBgSound() {
        try {
            if (bgPlayer == null && isGameAct) {
                startBgSound();
            } else if (isGameAct) {
                bgPlayer.start();
            }
        } catch (IllegalStateException e1) {
            Logger.e("播放器发生异常情况");
        }
    }

    private void stopBgSound() {
        try {
            if (bgPlayer != null && bgPlayer.isPlaying()) {
                bgPlayer.stop();
                bgPlayer.release();
                bgPlayer = null;
            }
        } catch (IllegalStateException e) {
            Logger.e("播放器发生异常情况");
        }
    }

    private void vibrator() {
        vibrator.vibrate(100);
    }

    static class RainHandler extends Handler {
        WeakReference<RedEnvelopFragment> fragmentWeakReference;

        RainHandler(RedEnvelopFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            RedEnvelopFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case RainView.RAIN_VIEW_CLICK:
                    fragment.rainClick((View) msg.obj);
                    break;
                case RainView.RAIN_VIEW_FINISHED:
                    fragment.gameOver();
                    break;
            }
        }
    }

    static class ResidueHandler extends Handler {
        WeakReference<RedEnvelopFragment> fragmentWeakReference;

        ResidueHandler(RedEnvelopFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            RedEnvelopFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case CountDown.COUNT_DOWN_TIMER:
                    fragment.setResidueTime((Long) msg.obj);
                    break;
                case CountDown.COUNT_DOWN_FINISH:
                    fragment.gameEnd();
                    break;
            }
        }
    }

    static class CountDownHandler extends Handler {
        WeakReference<RedEnvelopFragment> fragmentWeakReference;

        CountDownHandler(RedEnvelopFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            super.dispatchMessage(msg);
            RedEnvelopFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case CountDown.COUNT_DOWN_TIMER:
                    fragment.setCountdown((Long) msg.obj);
                    break;
                case CountDown.COUNT_DOWN_FINISH:
                    fragment.gameBegin();
                    break;
            }
        }
    }

    private void gradRequest(final View view) {
        Map<String, Object> map = new HashMap<>();
        map.put("activityId", redEnvelopeInfo.getActivityId());
        RetrofitUtils.getInstance().gradRedEnvelop(ParamUtils.getParam(map), new HttpBack<List<Ticket>>() {
            @Override
            public void onSuccess(List<Ticket> list) {
                if (list == null || list.size() <= 0) {
                    showEmptyView(view);
                } else {
                    gradRedEnvelop(view);
                    for (Ticket ticket : list) {
                        for (int i = 0; i < ticket.getTicketCount(); i++) {
                            ticketList.add(ticket);
                        }
                    }
                }
            }

            @Override
            public void onFailure(String msg) {
                showEmptyView(view);
            }
        });
    }

    private void request() {
        RetrofitUtils.getInstance(true).userRedEnvelopInfo(ParamUtils.getParam(null), userRedEnvelopInfoHttpBack);
    }

    private void startRequest() {
        RetrofitUtils.getInstance(true).startGradRedEnvelop(ParamUtils.getParam(null), startRedEnvelopInfoHttpBack);
    }
}
