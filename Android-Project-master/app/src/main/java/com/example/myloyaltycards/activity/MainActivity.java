package com.example.myloyaltycards.activity;

import android.content.Intent;
import android.os.Bundle;

import com.example.myloyaltycards.adapter.CardListAdapter;
import com.example.myloyaltycards.model.CardListDataManager;
import com.example.myloyaltycards.model.Card;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.lifecycle.Observer;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.View;

import com.example.myloyaltycards.R;
import com.google.android.material.snackbar.BaseTransientBottomBar;
import com.google.android.material.snackbar.Snackbar;

import java.util.List;

public class MainActivity extends AppCompatActivity {
    private CardListAdapter cardListAdapter;
    private final ActivityResultLauncher<Intent> getActivity = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(),
            new ActivityResultCallback<ActivityResult>() {
                @Override
                public void onActivityResult(ActivityResult result) {
                    int deletedCardID = result.getData().getIntExtra("deletedCardID", -1);
                    if(deletedCardID != -1) {
                        deleteCard(deletedCardID);
                    }
                }
            });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        init();
    }

    private void init() {
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        cardListAdapter = new CardListAdapter(this, getActivity);

        RecyclerView recyclerView = findViewById(R.id.recycler_view);
        recyclerView.setLayoutManager(new GridLayoutManager(this, 2));
        recyclerView.setAdapter(cardListAdapter);
        recyclerView.setHasFixedSize(true);

        CardListDataManager.getInstance(this).getCardsLiveData().observe(this, new Observer<List<Card>>() {
            @Override
            public void onChanged(List<Card> cards) {
                cardListAdapter.updateDataSet(cards);
            }
        });

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(MainActivity.this, AddCardActivity.class);
                startActivity(intent);
            }
        });
    }

    private void deleteCard(int deletedCardID) {
        Card deletedCard = cardListAdapter.deleteCard(deletedCardID);
        Snackbar snackbar = Snackbar.make(findViewById(R.id.main_coordinator_layout),
                R.string.snackbar_delete_message, Snackbar.LENGTH_LONG);
        snackbar.setAction(R.string.snackbar_undo_message, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                cardListAdapter.addCard(deletedCard);
            }
        });
        snackbar.addCallback(new BaseTransientBottomBar.BaseCallback<Snackbar>() {
            @Override
            public void onDismissed(Snackbar transientBottomBar, int event) {
                if(event == DISMISS_EVENT_MANUAL ||
                   event == DISMISS_EVENT_SWIPE ||
                   event == DISMISS_EVENT_TIMEOUT) {
                    CardListDataManager.getInstance(MainActivity.this).removeCard(deletedCard);
                }
            }
        });
        snackbar.show();
    }
}