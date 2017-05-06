package com.yldbkd.www.buyer.android.utils;

import com.yldbkd.www.buyer.android.bean.OrderDetail;

import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

/**
 * Created by HP on 2015/12/4.
 */
public class OrderStateManager {

    private List<OrderStateObsever> mObservers = new LinkedList<OrderStateObsever>();
    private static OrderStateManager instance;

    public static OrderStateManager getInstance() {
        if (instance == null) {
            synchronized (OrderStateManager.class) {
                if (instance == null) {
                    instance = new OrderStateManager();
                }
            }
        }
        return instance;
    }


    public synchronized void addObsever(OrderStateObsever observer) {
        if (!mObservers.contains(observer)) {
            mObservers.add(observer);
        }
    }

    public synchronized void deleteObserver(OrderStateObsever observer) {
        mObservers.remove(observer);
    }

    private synchronized void notifyStateChanged(OrderDetail order) {
        ListIterator<OrderStateObsever> iterator = mObservers.listIterator();
        while (iterator.hasNext()) {
            OrderStateObsever observer = iterator.next();
            observer.onStateUpdate(order);
        }
    }

    /**
     * 取消订单
     * @param order
     */
    public void cancel(OrderDetail order) {
        order.getOrderBaseInfo().setStatusCode(Constants.OrderStatus.CANCEL);
        notifyStateChanged(order);
    }

    public void finish(OrderDetail order) {
        order.getOrderBaseInfo().setStatusCode(Constants.OrderStatus.FINISH);
        notifyStateChanged(order);
    }

    public interface OrderStateObsever {
        void onStateUpdate(OrderDetail order);
    }
}
