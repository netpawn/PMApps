package com.example.myloyaltycards.adapter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.activity.result.ActivityResultLauncher;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.myloyaltycards.R;
import com.example.myloyaltycards.activity.DetailCardActivity;
import com.example.myloyaltycards.model.Card;

import org.jetbrains.annotations.NotNull;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

public class CardListAdapter extends RecyclerView.Adapter<CardListAdapter.CardViewHolder> {
    private List<Card> localDataSet;
    private Activity mainActivity;
    private ActivityResultLauncher<Intent> getActivity;

    public static class CardViewHolder extends RecyclerView.ViewHolder {
        private final TextView textView;
        private final ImageView imageView;

        public CardViewHolder(View view) {
            super(view);
            textView = view.findViewById(R.id.item_text_view);
            imageView = view.findViewById(R.id.item_image_view);
        }

        public TextView getTextView() {
            return textView;
        }
        public ImageView getImageView() {
            return imageView;
        }
        public void setBackgroundColor(int color) {
            CardView cardView = itemView.findViewById(R.id.list_item_card_view);
            cardView.setCardBackgroundColor(color);
        }
    }

    public CardListAdapter(Activity activity, ActivityResultLauncher<Intent> getActivity) {
        this.mainActivity = activity;
        this.getActivity = getActivity;
        localDataSet = new ArrayList<>();
    }

    public void updateDataSet(List<Card> cards) {
        if(cards != null) {
            localDataSet = cards;
            notifyDataSetChanged();
        }
    }

    public Card deleteCard(int deleteCardID) {
        Card cardToDelete = null;
        for(Card card : localDataSet)
            if(card.getUid() == deleteCardID)
                cardToDelete = card;
        if(cardToDelete != null) {
            int position = localDataSet.indexOf(cardToDelete);
            localDataSet.remove(cardToDelete);
            notifyItemRemoved(position);
        }
        return cardToDelete;
    }

    public void addCard(Card card) {
        if(card != null) {
            localDataSet.add(card);
            int position = localDataSet.indexOf(card);
            notifyItemInserted(position);
        }
    }

    private void showCardDetails(Context context, Card card) {
        Intent intent = new Intent(context, DetailCardActivity.class);
        intent.putExtra("id", card.getUid());
        getActivity.launch(intent);
    }

    @NotNull
    @Override
    public CardViewHolder onCreateViewHolder(ViewGroup viewGroup, int viewType) {
        View view = LayoutInflater.from(viewGroup.getContext())
                .inflate(R.layout.card_list_item, viewGroup, false);
        return new CardViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CardViewHolder cardViewHolder, final int position) {
        Card card = localDataSet.get(position);
        cardViewHolder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showCardDetails(view.getContext(), card);
            }
        });
        cardViewHolder.setBackgroundColor(card.getColor());
        if(card.getLogoPath() == null) {
            cardViewHolder.getImageView().setVisibility(View.GONE);
            cardViewHolder.getTextView().setVisibility(View.VISIBLE);
            cardViewHolder.getTextView().setText(card.getCompanyName());
        } else {
            cardViewHolder.getTextView().setVisibility(View.GONE);
            cardViewHolder.getImageView().setVisibility(View.VISIBLE);
            setLogoImage(cardViewHolder, card);
        }
    }

    @Override
    public int getItemCount() {
        return localDataSet.size();
    }

    private void setLogoImage(CardViewHolder cardViewHolder, Card card) {
        ImageView imageView = cardViewHolder.getImageView();
        Bitmap bitmap = getBitmapFromInternalStorage(card, imageView.getContext());
        imageView.setImageBitmap(bitmap);
    }

    private Bitmap getBitmapFromInternalStorage(Card card, Context context) {
        FileInputStream fileInputStream;
        Bitmap bitmap = null;
        try {
            fileInputStream = context.openFileInput(card.getLogoPath());
            bitmap = BitmapFactory.decodeStream(fileInputStream);
            fileInputStream.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return bitmap;
    }
}
