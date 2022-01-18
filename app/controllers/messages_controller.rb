class MessagesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        messages = Message.find_by_sql("select messages.number as MessageNumber , body , chats.number as chatNumber from messages left join chats on chats.id = messages.chat_id
        left join applications on applications .id = chats.application_id where applications.token = '"+params[:token]+"'
        and chats.number ="+params[:chatnumber])
        if !messages.blank?
            render json: {status: "SUCCESS",body: messages},status: :ok
        else
            render json: {status: "Error",error_message: "Messages_Not_Found"},status: :ok
        end
    end   

    # POST /message
    def create
        application = Application.where(token: params[:token]).first
        if !application.blank?
            chat = Chat.where(application_id: application.id,number: params[:chatnumber]).first   
            if !chat.blank?
                messageToCreate = Message.new(message_params)
                maxMessageNumberInChat = Message.where(chat_id: chat.id).maximum("number")

                currentMessageNumber = 1 
                if !maxMessageNumberInChat.nil?
                    currentMessageNumber = maxMessageNumberInChat + 1
                end

                messageToCreate.chat_id = chat.id
                messageToCreate.number = currentMessageNumber

                if messageToCreate.save
                    chat.message_count += 1
                    chat.save

                    render json: {status: "SUCCESS",messageNumber: messageToCreate.number},status: :created
                else
                    render json: {status: "ERROR",error_message: messageToCreate.errors},status: :unprocessable_entity
                end
            else
                render json: {status: "Error",error_message: "Chat_Not_Found"},status: :ok
            end
        else
            render json: {status: "Error",error_message: "Application_Not_Found"},status: :bad_request
        end    
    end

    def search
        unless params[:query].blank?
            messages = Message.search( params[:query] )
            render json: {status: "SUCCESS",body: messages},status: :ok
        end
    end

    private
    def message_params
        params.permit(:body)
    end
    
end