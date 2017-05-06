package com.yldbkd.www.buyer.android.adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import java.util.ArrayList;
import java.util.List;

public class FragmentAdapter extends FragmentPagerAdapter {
	private List<Fragment> fragments = new ArrayList<Fragment>();
	private List<String> titles;

	public FragmentAdapter(FragmentManager fm) {
		super(fm);
	}

	public FragmentAdapter(FragmentManager fm, List<String> titles) {
		super(fm);
		this.titles = titles;
	}

	public FragmentAdapter(FragmentManager fm, List<Fragment> fragments,
                           List<String> titles) {
		super(fm);
		this.fragments = fragments;
		this.titles = titles;
	}

	public void addItem(Fragment fragment) {
		fragments.add(fragment);
	}

	@Override
	public int getCount() {
		return fragments.size();
	}

	@Override
	public Fragment getItem(int position) {
		return fragments.get(position % fragments.size());
	}

	@Override
	public CharSequence getPageTitle(int position) {
		return titles.get(position % titles.size());
	}
}
